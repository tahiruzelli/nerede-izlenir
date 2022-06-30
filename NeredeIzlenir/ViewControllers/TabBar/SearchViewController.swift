//
//  SearchViewController.swift
//  NeredeIzlenir
//
//  Created by Tahir Uzelli on 23.06.2022.
//

import UIKit

class SearchViewController: BaseViewController {

    @IBOutlet weak var searchTextField: DesignableUITextField!
    @IBOutlet weak var movieTableView: UITableView!
    
    var isUserFinished: Bool = false
    
    var filteredMovies : [Movie] = []
    var lastSearchs : [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLastSearchs()
        movieTableView.delegate = self
        movieTableView.dataSource = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func getLastSearchs(){
        lastSearchs = Movie.getPrevisuSearch()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        filteredMovies = movies!.filter{ $0.title!.original!.lowercased().contains(searchTextField.text!.lowercased()) ||
            arrayToString(array: $0.people?.directors ?? []).lowercased().contains(searchTextField.text!.lowercased()) ||
            arrayToString(array: $0.people?.cast ?? []).lowercased().contains(searchTextField.text!.lowercased())
        }
        
        if filteredMovies.isEmpty {
            filteredMovies = []
            getLastSearchs()
        }
        else{
            lastSearchs = []
        }
        movieTableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchTextField.text!.isEmpty ? lastSearchs.count : filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCardTableViewCell", for: indexPath) as! MovieCardTableViewCell
        let cellRow = filteredMovies.isEmpty ? lastSearchs[indexPath.row] :  filteredMovies[indexPath.row]
        cell.titleLabel.text = cellRow.title?.original ?? ""
        cell.subTitleLabel.text = Genre.genresIdsToString(genreIds: cellRow.genres ?? [])
        cell.imdbLabel.text = String(cellRow.imdb?.rate ?? 0)
        cell.rottenLabel.text = String(cellRow.rotten?.rate ?? 0)
        cell.metaLabel.text = String(cellRow.metascore?.rate ?? 0)
        cell.tmdbLabel.text = String(cellRow.tmdb?.rate ?? 0)
        cell.descriptionLabel.text = String(cellRow.description?.tr ?? "")
        cell.movie = cellRow
        return cell
    }
}

