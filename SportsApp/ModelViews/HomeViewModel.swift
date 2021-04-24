//
//  HomeViewModel.swift
//  SportsApp
//
//  Created by Esraa on 24/04/2021.
//

import Foundation
class HomeViewModel: NSObject {
    
    var sportService :SportsService!
    
    var sportData : Welcome! {
        didSet{
            
            self.bindSportViewModelToView()
        }
        
    }
    
    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    
    
    var bindSportViewModelToView : (()->()) = {}
    var bindViewModelErrorToView : (()->()) = {}
    
    
    override init() {
        
        super .init()
        self.sportService = SportsService()
        self.fetchSportDataFromAPI()
    }
    
    
    func fetchSportDataFromAPI (){
        
        sportService.fetchSportsData(completion: { (sportData, error) in
            
            if let error : Error = error{
                
                let message = error.localizedDescription
                self.showError = message
                
            }else{
                
                self.sportData = sportData
                
            }
           
        })
    }

}
