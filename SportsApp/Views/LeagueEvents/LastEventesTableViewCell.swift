//
//  LastEventesTableViewCell.swift
//  SportsApp
//
//  Created by Esraa on 21/04/2021.
//

import UIKit

class LastEventesTableViewCell: UITableViewCell {

    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var dateLabelView: UILabel!
    @IBOutlet weak var countLabelView2: UILabel!
    @IBOutlet weak var countLabelView1: UILabel!
    @IBOutlet weak var imageViw2: UIImageView!
    @IBOutlet weak var imageView1: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
