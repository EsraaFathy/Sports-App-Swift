//
//  legueCellViewControllerTableViewCell.swift
//  sportsApp
//
//  Created by Nermeen on 4/21/21.
//  Copyright © 2021 Nermeen. All rights reserved.
//

import UIKit

class legueCellViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var legueImg: UIImageView!
    @IBOutlet weak var titleLegueLabel: UILabel!
    @IBOutlet weak var youtubeBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func openYoutubeChannal(_ sender: Any) {
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
