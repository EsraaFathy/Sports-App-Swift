//
//  LastEventsViewModel.swift
//  SportsApp
//
//  Created by Esraa on 25/04/2021.
//

import Foundation
class LastEventsViewModel: NSObject {
    
    var lastEventsService : LastEventService!
    
    var lastEventsData : LastAllEvents! {
        didSet{
            
            self.bindlastEventsViewModelToView()
        }
        
    }
    
    var showError : String! {
        
        didSet{
            
            self.bindViewModelErrorToView()
        }
        
    }
    
    
    var bindlastEventsViewModelToView : (()->()) = {}
    var bindViewModelErrorToView : (()->()) = {}
    
    
    override init() {
        
        super .init()
        self.lastEventsService = LastEventService()
        self.fetchLastEventsDataFromAPI()
    }
    
    
    func fetchLastEventsDataFromAPI (){
        
        lastEventsService.fetchlastEventsData(completion: { (upcommingtData, error) in
            
            if let error : Error = error{
                
                let message = error.localizedDescription
                self.showError = message
                
            }else{
                
                self.lastEventsData = upcommingtData
                
            }
           
        })
    }

}
