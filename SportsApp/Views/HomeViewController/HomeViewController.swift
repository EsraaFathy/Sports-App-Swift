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
    @IBOutlet weak var noConnectionImage: UIImageView!
    var sportsiewModel : HomeViewModel!

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
    }
    
    override func viewWillAppear(_ animated: Bool) {

        
        if isNetworkReachable() {
            self.noConnectionImage.isHidden = true
            self.collectionView.isHidden = false
            sportsiewModel = HomeViewModel()
            sportsiewModel.bindSportViewModelToView = {
                self.onSuccessUpdateView()
            }
            sportsiewModel.bindViewModelErrorToView = {
                self.onFailUpdateView()
            }
        }else{
            self.noConnectionImage.isHidden = false
            print("no network")
            self.noConnectionImage.image = UIImage(named: "n")
            self.collectionView.isHidden = true
        }
    }
    
    
    func onSuccessUpdateView(){
           
        dataArray = sportsiewModel.sportData.sports
        self.collectionView.reloadData()
           
       }
       
    func onFailUpdateView(){
        
       
        let alert = UIAlertController(title: "Error", message: sportsiewModel.showError, preferredStyle: .alert)
        
        let okAction  = UIAlertAction(title: "Ok", style: .default) { (UIAlertAction) in
            
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    private let manager = NetworkReachabilityManager(host: "www.apple.com")

    func isNetworkReachable() -> Bool {
        return manager?.isReachable ?? false
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "navHome" {
            let a = segue.destination as! LeguesTableViewController
            a.sportName = self.sportName
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isNetworkReachable() {
            self.sportName = dataArray[indexPath.row].strSport
            self.performSegue(withIdentifier: "navHome", sender: nil)
            print("pressed")
        }else{
            let alert = UIAlertController(title: "Error", message: "No Internet Connection", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }


    }
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        return CGSize(width: screenWidth/3, height: 160)
    }
    
    
}
