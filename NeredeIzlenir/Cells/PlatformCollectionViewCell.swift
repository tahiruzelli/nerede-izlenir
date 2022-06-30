//
//  PlatformCollectionViewCell.swift
//  NeredeIzlenir
//
//  Created by Tahir Uzelli on 22.06.2022.
//

import UIKit

class PlatformCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var platformImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        platformImage.dropShadow(color: .white, opacity: 0.3, offSet: CGSize(width: 0, height: 0), radius: 50, scale: false)
        
    }
}
