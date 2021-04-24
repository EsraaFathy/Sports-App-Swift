//
//  HomeViewController.swift
//  SportsApp
//
//  Created by Esraa on 19/04/2021.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    @IBOutlet weak var collectionView: UICollectionView!
    var dataArray = [Sport]()
    var sportName = ""
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(dataArray.count)
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! MYCollectionViewCell
        cell.labelView.text = dataArray[indexPath.row].strSport
        cell.imageView.layer.cornerRadius = 100.0
        cell.imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imageView!.sd_setImage(with: URL(string: dataArray[indexPath.row].strSportThumb), placeholderImage: UIImage(named: "placeholder"))
        

        print(indexPath.row)
                return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource=self
        collectionView.delegate=self
        fetchFilms()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "navHome" {
            let a = segue.destination as! LeguesTableViewController
            a.sportName = self.sportName
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.sportName = dataArray[indexPath.row].strSport
        self.performSegue(withIdentifier: "navHome", sender: nil)
        print("pressed")

    }
}

extension HomeViewController {
  func fetchFilms() {
        let url = "https://www.thesportsdb.com/api/v1/json/1/all_sports.php"
        AF.request(url).validate().responseJSON { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
               let sportsData = json["sports"]
                for s in sportsData {
                  let aa =  s.1.dictionaryObject!["strSport"] as! String
                    let sport = Sport(idSport: s.1.dictionaryObject!["idSport"] as! String, strSport: s.1.dictionaryObject!["strSport"] as! String, strFormat: s.1.dictionaryObject!["strFormat"] as! String, strSportThumb: s.1.dictionaryObject!["strSportThumb"] as! String, strSportThumbGreen: s.1.dictionaryObject!["strSportThumbGreen"] as! String, strSportDescription: s.1.dictionaryObject!["strSportDescription"] as! String)
                    self.dataArray.append(sport)
                    print(aa)
                }
                self.collectionView.reloadData()
                break
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }    
  }
    
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        return CGSize(width: screenWidth/3, height: 160)
    }
    
    
}
