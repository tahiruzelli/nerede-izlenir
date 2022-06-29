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
    }

}
