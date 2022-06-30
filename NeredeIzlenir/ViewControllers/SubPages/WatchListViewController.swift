//
//  WatchListViewController.swift
//  NeredeIzlenir
//
//  Created by Tahir Uzelli on 30.06.2022.
//

import UIKit

enum WatchListType : Codable {
    case watchList
    case previusWatch
    case none
}

class WatchListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var watchListTableView: UITableView!
    
    var movieList : [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieList()
        watchListTableView.delegate = self
        watchListTableView.dataSource = self
        
 
        
    }
    
    func getMovieList(){
        switch selectedWatchListType {
        case .watchList:
            movieList = Movie.getWatchList()
            titleLabel.text = "İzleme Listem"
            watchListTableView.reloadData()
        case .previusWatch:
            movieList = Movie.getPrevisuWatch()
            titleLabel.text = "İzlediklerim"
            watchListTableView.reloadData()
        case .none:
            movieList = []
            titleLabel.text = ""
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCardTableViewCell", for: indexPath) as! MovieCardTableViewCell
        let cellRow = movieList[indexPath.row]
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
