//
//  Usuario+CoreDataProperties.swift
//  SERVOSA
//
//  Created by ucweb on 21/07/16.
//  Copyright © 2016 ucweb. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Usuario {

    @NSManaged var apellidos: String?
    @NSManaged var email: String?
    @NSManaged var id: NSNumber?
    @NSManaged var id_tipo_usuario: NSNumber?
    @NSManaged var nombre: String?
    @NSManaged var tipo_usuario: String?
    @NSManaged var id_region: NSNumber?

}
