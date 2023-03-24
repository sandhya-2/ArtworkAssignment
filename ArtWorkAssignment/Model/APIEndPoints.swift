//
//  APIEndPoints.swift
//  ArtWorkAssignment
//
//  Created by admin on 15/03/2023.
//

import Foundation

struct APIEndpoints{
    /*the root URL*/
    static var baseURL = "https://api.artic.edu/api/v1/artworks?page="

    //base part
    static var imageURLBeginPoint: String = "https://www.artic.edu/iiif/2/"
    //end part
    static var imageEndPoint = "/full/843,/0/default.jpg"    
}

//static var baseURL = "https://api.artic.edu/api/v1/artworks?page="
