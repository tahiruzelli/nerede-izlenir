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
//        lastSearchs = UserDefaults.standard.object(forKey: lastSearchsKey) as? [Movie] ?? []
        lastSearchs = Movie.get()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let filteredArray = movies!.filter{ $0.title!.original!.contains(textField.text!) }
        filteredMovies = filteredArray
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
        return filteredMovies.isEmpty ? lastSearchs.count : filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCardTableViewCell", for: indexPath) as! MovieCardTableViewCell
        let cellRow = filteredMovies.isEmpty ? lastSearchs[indexPath.row] :  filteredMovies[indexPath.row]
        cell.titleLabel.text = cellRow.title?.original ?? ""
        cell.subTitleLabel.text = "TODO"
        cell.imdbLabel.text = String(cellRow.imdb?.rate ?? 0)
        cell.rottenLabel.text = String(cellRow.rotten?.rate ?? 0)
        cell.metaLabel.text = String(cellRow.metascore?.rate ?? 0)
        cell.tmdbLabel.text = String(cellRow.tmdb?.rate ?? 0)
        cell.descriptionLabel.text = String(cellRow.description?.tr ?? "")
//        cell.movieImage.downloaded(from: cellRow.poster.)
        cell.movie = cellRow
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // note that indexPath.section is used rather than indexPath.row
        print("You tapped cell number \(indexPath.row).")
    }
    
    
}

