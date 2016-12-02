//
//  Placa+CoreDataProperties.swift
//  SERVOSA
//
//  Created by ucweb on 19/07/16.
//  Copyright © 2016 ucweb. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Placa {

    @NSManaged var id_operacion: NSNumber?
    @NSManaged var id_placa: NSNumber?
    @NSManaged var placa: String?

}
