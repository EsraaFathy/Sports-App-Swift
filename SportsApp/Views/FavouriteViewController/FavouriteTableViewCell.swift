//
//  FavouriteTableViewCell.swift
//  SportsApp
//
//  Created by Esraa on 24/04/2021.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    @IBOutlet weak var youtubeImage: UIButton!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var leagueImage: UIImageView!
    var url : String = "www.youtube.com/user/ArsenalTour"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    @IBAction func openYoutupe(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: "https://\(self.url)")!)
        
//        let YoutubeQuery =  url
//         let escapedYoutubeQuery = YoutubeQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
//         let appURL = NSURL(string: "youtube://www.youtube.com/results?search_query=\(escapedYoutubeQuery!)")!
//         let webURL = NSURL(string: "https://www.youtube.com/results?search_query=\(escapedYoutubeQuery!)")!
//         let application = UIApplication.shared
//
//         if application.canOpenURL(appURL as URL) {
//             application.open(appURL as URL)
//         } else {
//             // if Youtube app is not installed, open URL inside Safari
//             application.open(webURL as URL)
//         }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
