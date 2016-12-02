//
//  Evento.swift
//  SERVOSA
//
//  Created by ucweb on 14/07/16.
//  Copyright © 2016 ucweb. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Evento: NSManagedObject {

    class func createEvento(json: AnyObject)-> Evento {
        
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let newEvento = NSEntityDescription.insertNewObjectForEntityForName("Evento", inManagedObjectContext: ap.managedObjectContext) as! Evento
        //Asignamos los valores
        newEvento.id_evento =  NSNumber(integer: Int((json["id_evento"] as! String))!)
        newEvento.codigo_evento = json["codigo_evento"] as? String
        newEvento.nombre_evento = json["nombre_evento"] as? String
        
        //Guardamos la informacion
        ap.saveContext()
        return newEvento
        
    }
    
    class func getEventos()->[Evento]?{
        let resquest = NSFetchRequest(entityName: "Evento")
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        do{
            let evento = try ap.managedObjectContext.executeFetchRequest(resquest) as! [Evento]
            if let _ = evento.first{
                return evento
            }else{
                return nil
            }
            
        }catch {
            return nil
        }
        
    }
    
    class func addCategoria(json: AnyObject)-> [Categoria]{
        let categorias = json as![AnyObject]
        let categoriaSet = NSMutableSet()
        for categoria in categorias{
            categoriaSet.addObject(Categoria.createCategoria(categoria))
        }
        return categoriaSet.allObjects as! [Categoria]
    }
    

}
