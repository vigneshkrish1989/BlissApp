//
//  Users+CoreDataProperties.swift
//  BlissApp
//
//  Created by Vignesh Krishnamurthy on 04/09/21.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var avatar: String?

}

extension Users : Identifiable {

}
