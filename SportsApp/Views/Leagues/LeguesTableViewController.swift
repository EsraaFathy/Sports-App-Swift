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

class LeguesTableViewController: UITableViewController, OpenWep, UISearchBarDelegate {
    

    @IBOutlet var searchBarView: UISearchBar!
    var leagues : [Countrys] = [Countrys]()
    var leagueViewModel : LeagueViewModel!
    var sportName : String = ""
    var leadueID = ""
    var model :FavoriteModelCoreData!
    var flag = false
    var filterdLeagues : [Countrys] = [Countrys]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchBarView

        // 1
        searchBarView.delegate = self
        definesPresentationContext = true
        
        
        
        
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
        self.youtubeLink = leagues[indexPath.row].strYoutube ?? "https://youtube.com"
        self.leadueID = leagues[indexPath.row].idLeague!
        self.model = FavoriteModelCoreData(Title: leagues[indexPath.row].strLeague ?? ""
                                           , Image: leagues[indexPath.row].strBadge ?? "",
                                           Youtube: leagues[indexPath.row].strYoutube ?? "",
                                           ID: leagues[indexPath.row].idLeague ?? "")
        self.performSegue(withIdentifier: "nav", sender: nil)


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
        if flag == true {
            return filterdLeagues.count
        }else{
        return leagues.count
        }
    }
    var youtubeLink = ""
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "nav" {
                let a = segue.destination as! LeagueEventsViewController
                a.id = self.leadueID
                a.model = self.model
            }
        }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! legueCellViewControllerTableViewCell
        cell.openWeb = self
        if flag == true {
            
            if(filterdLeagues[indexPath.row].strYoutube == ""){
                cell.youtubeBtn.isHidden=true
                cell.youtubeBtn.heightAnchor.constraint(equalToConstant: CGFloat(0)).isActive=true
            }
            cell.titleLegueLabel.text=filterdLeagues[indexPath.row].strLeague
            if filterdLeagues[indexPath.row].strBadge != nil {
                cell.legueImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
                cell.legueImg.sd_setImage(with: URL(string:filterdLeagues[indexPath.row].strBadge!),placeholderImage: UIImage(named: "placeholder"))
                       cell.legueImg.layer.cornerRadius = 30.0
            }
            cell.url = filterdLeagues[indexPath.row].strYoutube ?? "https://youtube.com"
            
            
            return cell
        }else{
        if(leagues[indexPath.row].strYoutube == ""){
            cell.youtubeBtn.isHidden=true
            cell.youtubeBtn.heightAnchor.constraint(equalToConstant: CGFloat(0)).isActive=true
        }
        cell.titleLegueLabel.text=leagues[indexPath.row].strLeague
        if leagues[indexPath.row].strBadge != nil {
            cell.legueImg.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.legueImg.sd_setImage(with: URL(string:leagues[indexPath.row].strBadge!),placeholderImage: UIImage(named: "placeholder"))
                   cell.legueImg.layer.cornerRadius = 30.0
        }
        cell.url = leagues[indexPath.row].strYoutube ?? "https://youtube.com"
        return cell
        }
    }
    
    
    func openWebPage() {
        print("youtubeLink................ \(youtubeLink)")
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "YoutubeViewController") as! YoutubeViewController
        newViewController.url = self.youtubeLink
        self.navigationController?.pushViewController(newViewController, animated: true)
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

extension LeguesTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    print("updaated")
  }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        filterdLeagues = [Countrys]()
        if searchText == "" {
            flag = false
            self.tableView.reloadData()
        }else{
            flag = true
            for c in leagues {
                if c.strLeague?.contains(searchText) == true {
                    filterdLeagues.append(c)
                }
            }
            
            
            self.tableView.reloadData()
        }
        
    }
}
