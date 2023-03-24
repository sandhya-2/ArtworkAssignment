//
//  ArtBaseModel.swift
//  ArtWorkAssignment
//
//  Created by admin on 15/03/2023.
//

import Foundation

struct ArtBaseModel: Codable{
    let pagination: Pagination
    let data:[ArtworkData]
    let info:Info
    let config:Config
}

struct ArtworkData: Codable, Identifiable, Hashable{
   
    let id: Int?
    let title: String?
    let place_of_origin: String?
    let artist_title: String?
    let artist_display: String?
    let image_id: String?
}

struct Pagination: Codable{
    let total, limit, offset, totalPages: Int
       let currentPage: Int
       let nextURL: String

       enum CodingKeys: String, CodingKey {
           case total, limit, offset
           case totalPages = "total_pages"
           case currentPage = "current_page"
           case nextURL = "next_url"
       }
}

struct Info: Codable{
    let licenseText: String
       let licenseLinks: [String]
       let version: String

       enum CodingKeys: String, CodingKey {
           case licenseText = "license_text"
           case licenseLinks = "license_links"
           case version
       }
}

struct Config: Codable{
    let iiifURL: String
        let websiteURL: String

        enum CodingKeys: String, CodingKey {
            case iiifURL = "iiif_url"
            case websiteURL = "website_url"
        }
}


