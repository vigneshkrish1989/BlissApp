//
//  AppConstants.swift
//  BlissApp
//
//  Created by Vignesh Krishnamurthy on 04/09/21.
//

import Foundation

struct BaseAPI {
    static let BaseURL = "https://api.github.com/"
}

struct emojiAPI{
    static let getEmojis = BaseAPI.BaseURL+"emojis"
}
struct userAPI{
    var getUser = ""
    init(username: String) {
        getUser = BaseAPI.BaseURL+"users/\(username)"
    }
}
struct appleRepoAPI{
    var getAppleRepo = ""
    init(page: Int, size: Int) {
        getAppleRepo = BaseAPI.BaseURL+"users/apple/repos?page=\(page)&size=\(size)"
    }
}
