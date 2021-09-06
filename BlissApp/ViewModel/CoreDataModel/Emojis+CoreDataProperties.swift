//
//  Emojis+CoreDataProperties.swift
//  BlissApp
//
//  Created by Vignesh Krishnamurthy on 02/09/21.
//
//

import Foundation
import CoreData


extension Emojis {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Emojis> {
        return NSFetchRequest<Emojis>(entityName: "Emojis")
    }

    @NSManaged public var name: String?

}

extension Emojis : Identifiable {

}
