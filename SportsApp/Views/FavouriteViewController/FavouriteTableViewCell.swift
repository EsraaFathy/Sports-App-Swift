//
//  FavouriteTableViewCell.swift
//  SportsApp
//
//  Created by Esraa on 24/04/2021.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    @IBOutlet weak var youtubeImage: UIImageView!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var leagueImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
