//
//  Networking.swift
//  SportsApp
//
//  Created by Esraa on 21/04/2021.
//

import Foundation
import Alamofire
import SwiftyJSON

class Networking{
//    func fetchFilms() {
//          let url = "https://www.thesportsdb.com/api/v1/json/1/all_sports.php"
//          AF.request(url).validate().responseJSON { response in
//              switch response.result {
//              case .success(let data):
//                  let json = JSON(data)
//                 let sportsData = json["sports"]
//                  for s in sportsData {
//                    let aa =  s.1.dictionaryObject!["strSport"] as! String
//                      let sport = Sport(idSport: s.1.dictionaryObject!["idSport"] as! String, strSport: s.1.dictionaryObject!["strSport"] as! String, strFormat: s.1.dictionaryObject!["strFormat"] as! String, strSportThumb: s.1.dictionaryObject!["strSportThumb"] as! String, strSportThumbGreen: s.1.dictionaryObject!["strSportThumbGreen"] as! String, strSportDescription: s.1.dictionaryObject!["strSportDescription"] as! String)
//                      self.dataArray.append(sport)
//                      print(aa)
//                  }
//                  self.collectionView.reloadData()
//                  break
//              case .failure(let error):
//                  print("Request failed with error: \(error)")
//              }
//          }
//    }
}
