//
//  BusiLogic.swift
//  BlissApp
//
//  Created by Vignesh Krishnamurthy on 01/09/21.
//

import Foundation
import UIKit
import CoreData

struct ParseData {
    
    //MARK:- GET EMOJIS
    func getEmojisCall(onSucesses:@escaping(Bool) ->Void,onFailure:@escaping(Any)->Void) {
        guard let api = URL(string: emojiAPI.getEmojis) else {return}
        var request = URLRequest(url: api)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
       
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do {
              let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: .allowFragments) as! [String: String]
                
                let values = jsonResponse.map { $0.value }
                print("Values",values)
                
                for emoji in values {
                    
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Emojis")
                    fetchRequest.predicate = NSPredicate(format: "name = %@", emoji)
                    
                    do{
                        
                        if let fetchResults = try PersistenceService.context.fetch(fetchRequest) as? [NSManagedObject]
                            
                        {
                            if fetchResults.count != 0{
                                print("Data already exist!")
                            }
                            else
                            {
                                let getEmoji = Emojis(context: PersistenceService.context)
                                getEmoji.name = emoji
                                PersistenceService.saveContext()
                            }
                        }
                    }
                    catch{}
                }

                onSucesses(true)
            }
            catch{
              print(error)
                onFailure(error)
            }
        }.resume()
    }
    
    //MARK:- GET USER
    func getUser(username: String, completion : @escaping (userList) -> ()){
        guard let api = URL(string: userAPI(username: username).getUser) else {return}
        let request = URLRequest(url: api)
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                
                let result = try JSONDecoder().decode(userList.self, from: dataResponse)
                let values = result.avatar_url
                print("Values",values ?? "")
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
                fetchRequest.predicate = NSPredicate(format: "avatar = %@", values ?? "")
                
                do{
                    
                    if let fetchResults = try PersistenceService.context.fetch(fetchRequest) as? [NSManagedObject]
                        
                    {
                        if fetchResults.count != 0{
                            print("Data already exist!")
                        }
                        else
                        {
                            let getUser = Users(context: PersistenceService.context)
                            getUser.avatar = values
                            PersistenceService.saveContext()
                        }
                    }
                }
                catch{}
                
                
                
                completion(result)
                
            } catch {
                print("Error", error)
                }
        }.resume()
    }
      
    //MARK:- APPLE REPOS
    func getAppleRepos(page: Int, size: Int, completion : @escaping ([appleRepo]) -> ()){
        guard let api = URL(string: appleRepoAPI(page: page, size: size).getAppleRepo) else {return}
        let request = URLRequest(url: api)
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                let result = try JSONDecoder().decode(Array<appleRepo>.self, from: dataResponse)
                completion(result)
                
            } catch {
                print("Error", error)
                }
        }.resume()
    }
}
