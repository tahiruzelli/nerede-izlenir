//
//  GenreCardTableViewCell.swift
//  NeredeIzlenir
//
//  Created by Tahir Uzelli on 27.06.2022.
//

import UIKit

class GenreCardTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    var currentGenre : Genre?
    var currentIndex : Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         self.selectionStyle = .none
     }

     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
     }

}
