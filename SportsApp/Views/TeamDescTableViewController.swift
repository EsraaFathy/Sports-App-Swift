//
//  TeamDescTableViewController.swift
//  sportsApp
//
//  Created by Nermeen on 4/27/21.
//  Copyright © 2021 Nermeen. All rights reserved.
//

import UIKit

class TeamDescTableViewController: UITableViewController {

    @IBOutlet weak var teamDesc: UILabel!
    @IBOutlet weak var coverImgView: UIImageView!
    @IBOutlet weak var teamImgView: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamLeague: UILabel!
    @IBOutlet weak var teamCountry: UILabel!
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var twitterBtn: UIButton!
    @IBOutlet weak var instgramBtn: UIButton!
    var teamViewModel :TeamDescViewModel!
    var team = [Teams]()
    var teamID:String!
    var linkYoutube = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        URLs.teamId = self.teamID
        teamViewModel = TeamDescViewModel()
        teamViewModel.bindTeamViewModelToView = {
                    
            self.onSuccessUpdateView()
            
        }
        
        teamViewModel.bindViewModelErrorToView = {
                    
            self.onFailUpdateView()
            
        }
    //    print("teeeeeeeeaaaaaaam\(team)")
     
    }
    func onSuccessUpdateView(){
           
        self.team = teamViewModel.teamData.teams!
        if(team[0].strFacebook==""){
                  facebookBtn.isHidden=true
                facebookBtn.heightAnchor.constraint(equalToConstant: CGFloat(0)).isActive=true
              }
        if(team[0].strTwitter==""){
                         twitterBtn.isHidden=true
                       twitterBtn.heightAnchor.constraint(equalToConstant: CGFloat(0)).isActive=true
                     }
        if(team[0].strInstagram==""){
                         instgramBtn.isHidden=true
                       instgramBtn.heightAnchor.constraint(equalToConstant: CGFloat(0)).isActive=true
                     }
        teamName.text = team[0].strTeam!
             teamDesc.text = team[0].strDescriptionEN
             teamLeague.text = team[0].strLeague!
             teamCountry.text = team[0].strCountry!
             teamImgView.sd_setImage(with: URL(string:team[0].strTeamBadge!),placeholderImage: UIImage(named: "1"))
                    teamImgView.layer.cornerRadius = 30.0
        print(team[0].strStadiumThumb ?? "nill")
             coverImgView.sd_setImage(with: URL(string:team[0].strStadiumThumb ?? ""),placeholderImage: UIImage(named: "std"))
                   
       }
       
       func onFailUpdateView(){
           
          
           let alert = UIAlertController(title: "Error", message: teamViewModel.showError, preferredStyle: .alert)
           
           let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
               
               
           }
           
           
           alert.addAction(okAction)
           self.present(alert, animated: true, completion: nil)
           
       }
  
    @IBAction func openFacebookAction(_ sender: Any) {
        let youtubeView = self.storyboard!.instantiateViewController(withIdentifier: "YoutubeViewController") as! YoutubeViewController
                youtubeView.url = self.team[0].strFacebook!
                self.navigationController?.pushViewController(youtubeView, animated: true)
    }
    
    @IBAction func openTwitterAction(_ sender: Any) {
        let youtubeView = self.storyboard!.instantiateViewController(withIdentifier: "YoutubeViewController") as! YoutubeViewController
        youtubeView.url = self.team[0].strTwitter!
        self.navigationController?.pushViewController(youtubeView, animated: true)
    }
    
    @IBAction func openInstagramAction(_ sender: Any) {
        let youtubeView = self.storyboard!.instantiateViewController(withIdentifier: "YoutubeViewController") as! YoutubeViewController
                      youtubeView.url = self.team[0].strInstagram!
                      self.navigationController?.pushViewController(youtubeView, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let a = segue.destination as! YoutubeViewController
            a.url = self.linkYoutube
        print("home \(self.linkYoutube) ..... away \(a.url)")
    }
    
}
