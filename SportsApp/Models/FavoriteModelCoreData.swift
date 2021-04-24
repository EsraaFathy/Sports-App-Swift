//
//  FavoriteModelCoreData.swift
//  SportsApp
//
//  Created by Esraa on 23/04/2021.
//

import Foundation
class FavoriteModelCoreData{
    var title : String?
    var image : String?
    var youtube : String?
    var id : String?
    init(Title title : String,Image image:String, Youtube youtube:String, ID id: String) {
        self.title=title
        self.image=image
        self.youtube=youtube
        self.id=id
    }
}
