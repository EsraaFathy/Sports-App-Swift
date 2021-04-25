//
//  UpcommingService.swift
//  SportsApp
//
//  Created by Esraa on 24/04/2021.
//

import Foundation
import Alamofire



class UpcommingService{
    
    
    func fetchUpcommingData(completion : @escaping (UpCommingEventEntity?, Error?)->()){
        
        AF.request(URLs.upCommingURL)
            .validate()
            .responseDecodable(of: UpCommingEventEntity.self) { (response) in
                switch response.result {
                
                case .success( _):
                    
                    guard let upcommingData = response.value else { return }

                    completion(upcommingData,nil)
                    
                    
                case .failure(let error):
                    
                    completion(nil , error)
                    
                    
                }
            }
    }
    
}

