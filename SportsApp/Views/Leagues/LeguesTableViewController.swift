//
//  LeguesTableViewController.swift
//  sportsApp
//
//  Created by Nermeen on 4/21/21.
//  Copyright © 2021 Nermeen. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage

class LeguesTableViewController: UITableViewController {

    var leagues : [Countrys] = [Countrys]()
    var leagueViewModel : LeagueViewModel!
    var sportName : String = ""
    var leadueID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        URLs.getLeagueListURL = "https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?s=\(sportName)"
        print("sport name from home .... \(URLs.getLeagueListURL)")
         leagueViewModel = LeagueViewModel()
        leagueViewModel.bindLeagueViewModelToView = {

                  self.onSuccessUpdateView()

              }

              leagueViewModel.bindViewModelErrorToView = {

                  self.onFailUpdateView()

              }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.leadueID = leagues[indexPath.row].idLeague!
        self.performSegue(withIdentifier: "nav", sender: nil)


    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "nav" {
                let a = segue.destination as! LeagueEventsViewController
                a.id = self.leadueID
                }
        }
    func onSuccessUpdateView(){
           
        leagues = leagueViewModel.leagueData.countrys!
           self.tableView.reloadData()
           
       }
       
       func onFailUpdateView(){
           
          
           let alert = UIAlertController(title: "Error", message: leagueViewModel.showError, preferredStyle: .alert)
           
           let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
               
               
           }
           
           
           alert.addAction(okAction)
           self.present(alert, animated: true, completion: nil)
           
       }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! legueCellViewControllerTableViewCell
        if(leagues[indexPath.row].strYoutube==nil){
            cell.youtubeBtn.isHidden=true
            cell.youtubeBtn.heightAnchor.constraint(equalToConstant: CGFloat(0)).isActive=true
        }
        cell.titleLegueLabel.text=leagues[indexPath.row].strLeague
        cell.legueImg.sd_setImage(with: URL(string:leagues[indexPath.row].strBadge!),placeholderImage: UIImage(named: "1"))
       
               cell.legueImg.layer.cornerRadius = 30.0

        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 170.0
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
