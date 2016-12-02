//
//  Tipo+CoreDataProperties.swift
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

extension Tipo {

    @NSManaged var codigo_tipo: String?
    @NSManaged var id_categoria: NSNumber?
    @NSManaged var id_tipo: NSNumber?
    @NSManaged var nombre_tipo: String?

}
