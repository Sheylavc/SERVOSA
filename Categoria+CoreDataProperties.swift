//
//  Categoria+CoreDataProperties.swift
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

extension Categoria {

    @NSManaged var codigo_categoria: String?
    @NSManaged var id_categoria: NSNumber?
    @NSManaged var id_evento: NSNumber?
    @NSManaged var nombre_categoria: String?

}
