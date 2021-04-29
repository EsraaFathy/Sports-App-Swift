//
//  FavouriteViewController.swift
//  SportsApp
//
//  Created by Esraa on 19/04/2021.
//

import UIKit
import SDWebImage
import CoreData
import Alamofire

class FavouriteViewController: UIViewController {
    var arrayOfFafourite = [FavoriteModelCoreData]()
    var row : Int!
    private let manager = NetworkReachabilityManager(host: "www.apple.com")
    
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
        cell.url = arrayOfFafourite[indexPath.row].youtube ?? ""
        
        if arrayOfFafourite[indexPath.row].youtube != "" {
//            cell.youtubeImage.imageView?.image = UIImage(named: "y")
            cell.youtubeImage.setImage(UIImage(named: "y"), for: .normal)
            print("shoooowooooooooooow")
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
                }
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        featchCoreData()
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isNetworkReachable() {
            self.row = indexPath.row
            self.performSegue(withIdentifier: "favL", sender: nil)
        }else{
            let alert = UIAlertController(title: "Error", message: "No Internet Connection", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favL" {
            let a = segue.destination as! LeagueEventsViewController
            a.id = arrayOfFafourite[row].id!
            }
    }
    func isNetworkReachable() -> Bool {
        return manager?.isReachable ?? false
    }
}
