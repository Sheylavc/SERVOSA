//
//  Listado+CoreDataProperties.swift
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

extension Listado {

    @NSManaged var categoria: String?
    @NSManaged var descripcion: String?
    @NSManaged var estado: String?
    @NSManaged var evento: String?
    @NSManaged var fecha: String?
    @NSManaged var id_categoria: NSNumber?
    @NSManaged var id_evento: NSNumber?
    @NSManaged var id_listado: NSNumber?
    @NSManaged var id_operacion: NSNumber?
    @NSManaged var id_placa: NSNumber?
    @NSManaged var id_ruta: NSNumber?
    @NSManaged var id_tipo: NSNumber?
    @NSManaged var id_tramo: NSNumber?
    @NSManaged var operacion: String?
    @NSManaged var placa: String?
    @NSManaged var ruta: String?
    @NSManaged var tipo: String?
    @NSManaged var tramo: String?

}
