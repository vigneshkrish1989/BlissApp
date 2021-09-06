//
//  UserModel.swift
//  BlissApp
//
//  Created by Vignesh Krishnamurthy on 04/09/21.
//

import Foundation

struct userList: Codable {
    var login: String?
    var id: Int?
    var avatar_url: String?
}

struct appleRepo: Codable {
    var name: String?
}
