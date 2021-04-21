//
//  HomeViewController.swift
//  SportsApp
//
//  Created by Esraa on 19/04/2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFilms()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("segue prepared called")
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
//                   let aa = s as! Dictionary<String,String>
//                    print("..........")
//                    let j = JSON(s)
                    print(aa)
                }
                break
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }

//    }
    
  }
    
}
