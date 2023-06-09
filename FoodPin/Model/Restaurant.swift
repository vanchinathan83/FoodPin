//
//  Restaurant.swift
//  FoodPin
//
//  Created by Vanchinathan AC on 3/28/23.
//

import Foundation

struct Restaurant : Hashable{
    var name: String
    var type: String
    var location: String
    var image: String
    var isFavorite: Bool
    var phone: String
    var description: String
    
    init(name: String, type: String, location: String, image: String, isFavorite: Bool, phone: String, description: String) {
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isFavorite = isFavorite
        self.phone = phone
        self.description = description
    }
    
    init(){
        self.init(name: "", type: "", location: "", image: "", isFavorite: false, phone: "", description: "")
    }
}
