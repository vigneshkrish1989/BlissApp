//
//  Parser.swift
//  BlissApp
//
//  Created by Vignesh Krishnamurthy on 04/09/21.
//

import Foundation
import CoreData

let parser = ParseData()
var getAppleRepo = [appleRepo]()


struct Parser {
    
     func parseEmojis(completion : @escaping ([Emojis]) -> ()){
        parser.getEmojisCall(onSucesses: {
            success in
            print(success)
            let fetchRequest: NSFetchRequest<Emojis> = Emojis.fetchRequest()
            do{
                let getEmojis = try PersistenceService.context.fetch(fetchRequest)
                completion(getEmojis)
            }catch{}
            
        }, onFailure: {
            failure in
            print(failure)
        })
    }
    
    
    func parseUser(username: String, completion : @escaping (userList) -> ()){
        parser.getUser(username: username, completion: {
            result in
            completion(result)
        })
   }
    func parseUserAvatar(completion : @escaping ([Users]) -> ()){
        let fetchRequest: NSFetchRequest<Users> = Users.fetchRequest()
        do{
            let getAvatar = try PersistenceService.context.fetch(fetchRequest)
            completion(getAvatar)
        }catch{}
   }

}



