//
//  ContentCollectionViewCell.swift
//  NeredeIzlenir
//
//  Created by Tahir Uzelli on 21.06.2022.
//

import UIKit

class ContentCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var gradientView: UIView!
    
    var movie : Movie?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setGradientBackground()
        
//        backgroundButton.addTarget(self, action: #selector(testfuncc), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        movieImage.downloaded(from: movie?.poster?.tmdbPoster?.en ?? movie?.backdrops?.first ?? "")
    }
    
    func setGradientBackground() {
        let colorTop = UIColor.black.withAlphaComponent(0.0).cgColor
        let colorBottom = UIColor.black.cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = gradientView.bounds

        gradientView.layer.insertSublayer(gradientLayer, at:0)
    }
    
    @IBAction func cellPressedAction(_ sender: Any) {
        currentMovie = movie
    }
        
    
}
