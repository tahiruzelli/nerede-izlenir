//
//  MovieDetailViewController.swift
//  NeredeIzlenir
//
//  Created by Tahir Uzelli on 24.06.2022.
//

import UIKit

class MovieDetailViewController: BaseViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var orTitleLabel: UILabel!
    @IBOutlet weak var movieTypeLabel: UILabel!
    
    @IBOutlet weak var tmdbLabel: UILabel!
    @IBOutlet weak var metaLabel: UILabel!
    @IBOutlet weak var rottenLabel: UILabel!
    @IBOutlet weak var imdbLabel: UILabel!
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var artistsLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var watchListImage: UIImageView!
    @IBOutlet weak var previusWatchImage: UIImageView!
    
    
    var movie : Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movie = currentMovie
        
        movieImage.downloaded(from: movie?.backdrops?.first ?? movie?.backdrops?.last ?? movie?.poster?.tmdbPoster?.en ?? "")
        titleLabel.text = movie?.title?.tr
        orTitleLabel.text = movie?.title?.original
        movieTypeLabel.text = Genre.genresIdsToString(genreIds: (movie?.genres) ?? [])
        
        tmdbLabel.text = "\(movie?.tmdb?.rate ?? 0)"
        metaLabel.text = "\(movie?.metascore?.rate ?? 0)"
        rottenLabel.text = "\(movie?.rotten?.rate ?? 0)"
        imdbLabel.text  = "\(movie?.imdb?.rate ?? 0)"
        
        timeLabel.text = movie?.runtime
        artistsLabel.text = arrayToString(array: movie?.people?.cast ?? [])
        directorLabel.text = arrayToString(array: movie?.people?.directors ?? [])
        countryLabel.text = arrayToString(array: movie?.country ?? [])
    
        descriptionLabel.text = movie?.description?.tr
        
        var tap = UITapGestureRecognizer(target: self, action: #selector(onPreviusWatchImageTapped))
        previusWatchImage.isUserInteractionEnabled = true
        previusWatchImage.addGestureRecognizer(tap)
        tap = UITapGestureRecognizer(target: self, action: #selector(onWatchListImageTapped))
        watchListImage.isUserInteractionEnabled = true
        watchListImage.addGestureRecognizer(tap)
        
        
    }
    
    @objc func onPreviusWatchImageTapped(){
        let alert = UIAlertController(title: "Uyarı", message: "\(movie?.title?.original ?? "") filmi daha önce izlendi olarak kaydedilecek ve bundan sonra size gösterilmeyecektir.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.cancel, handler: {action in
            Movie.savePreviusWatch(value: self.movie!)
        }))
        alert.addAction(UIAlertAction(title: "Vazgeç", style: UIAlertAction.Style.destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func onWatchListImageTapped(){
        let alert = UIAlertController(title: "Uyarı", message: "\(movie?.title?.original ?? "") filmi daha sonra izlenecek olarak kaydedilecek ve bundan sonra size gösterilmeyecektir.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.cancel, handler: {action in
            Movie.saveWatchList(value: self.movie!)
        }))
        alert.addAction(UIAlertAction(title: "Vazgeç", style: UIAlertAction.Style.destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
