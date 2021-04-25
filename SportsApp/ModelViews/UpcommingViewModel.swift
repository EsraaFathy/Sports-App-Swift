//
//  UpcommingViewModel.swift
//  SportsApp
//
//  Created by Esraa on 24/04/2021.
//

import Foundation
class UpcommingViewModel: NSObject {
    
    var upcommingService : UpcommingService!
    
    var UpcommingData : UpCommingEventEntity! {
        didSet{
            
            self.bindUpcommingViewModelToView()
        }
        
    }
    
    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    
    
    var bindUpcommingViewModelToView : (()->()) = {}
    var bindViewModelErrorToView : (()->()) = {}
    
    
    override init() {
        
        super .init()
        self.upcommingService = UpcommingService()
        self.fetchUpcommingDataFromAPI()
    }
    
    
    func fetchUpcommingDataFromAPI (){
        
        upcommingService.fetchUpcommingData(completion: { (upcommingtData, error) in
            
            if let error : Error = error{
                
                let message = error.localizedDescription
                self.showError = message
                
            }else{
                
                self.UpcommingData = upcommingtData
                
            }
           
        })
    }

}
