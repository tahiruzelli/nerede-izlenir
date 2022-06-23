//
//  MovieCardTableViewCell.swift
//  NeredeIzlenir
//
//  Created by Tahir Uzelli on 23.06.2022.
//

import UIKit

class MovieCardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var rottenLabel: UILabel!
    @IBOutlet weak var metaLabel: UILabel!
    @IBOutlet weak var tmdbLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left:0, bottom: 10,right:0 ))
    }

}
