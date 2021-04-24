//
//  FavouriteViewController.swift
//  SportsApp
//
//  Created by Esraa on 19/04/2021.
//

import UIKit
import SDWebImage
import CoreData

class FavouriteViewController: UIViewController {
    var arrayOfFafourite = [FavoriteModelCoreData]()
    var row = 1

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}
extension FavouriteViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfFafourite.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! FavouriteTableViewCell
        cell.leagueImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.leagueImage.sd_setImage(with: URL(string: arrayOfFafourite[indexPath.row].image!), placeholderImage: UIImage(named: "placeholder"))
        cell.leagueLabel.text = arrayOfFafourite[indexPath.row].title
        if arrayOfFafourite[indexPath.row].youtube != "" {
            cell.youtubeImage.image = UIImage(named: "y")
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func featchCoreData(){
        arrayOfFafourite = [FavoriteModelCoreData]()
        var arrayfdNSManagedObject = [NSManagedObject]()
        let appDeleget = UIApplication.shared.delegate as! AppDelegate
        let cont = appDeleget.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavouriteCoreData")
        do {
            arrayfdNSManagedObject = try! cont.fetch(fetchRequest)
            for i in arrayfdNSManagedObject {
                let fav = FavoriteModelCoreData(Title: i.value(forKey: "title") as! String, Image: i.value(forKey: "image") as! String, Youtube: i.value(forKey: "youtube") as! String, ID: i.value(forKey: "id") as! String)
                self.arrayOfFafourite.append(fav)
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Your Code Here...
        featchCoreData()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.row = indexPath.row
        self.performSegue(withIdentifier: "favL", sender: nil)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favL" {
            let a = segue.destination as! LeagueEventsViewController
            a.id = arrayOfFafourite[row].id!
            }
    }
}
