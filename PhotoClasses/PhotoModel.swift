//
//  PhotoModel.swift
//  NewProject
//
//  Created by user on 6/28/19.
//  Copyright © 2019 Razeware. All rights reserved.
//

import Foundation


struct PhotoModel : Decodable {
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
}
