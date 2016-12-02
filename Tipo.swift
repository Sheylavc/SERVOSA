//
//  Tipo.swift
//  SERVOSA
//
//  Created by ucweb on 14/07/16.
//  Copyright © 2016 ucweb. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Tipo: NSManagedObject {

    class func createTipo(json: AnyObject)->Tipo{
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        let newTipo = NSEntityDescription.insertNewObjectForEntityForName("Tipo", inManagedObjectContext: ap.managedObjectContext) as! Tipo

        newTipo.id_tipo =  NSNumber(integer: Int((json["id_tipo"] as! String))!)
        newTipo.id_categoria =  NSNumber(integer: Int((json["id_categoria"] as! String))!)
        newTipo.codigo_tipo = json["codigo_tipo"] as? String
        newTipo.nombre_tipo = json["nombre_tipo"] as? String
        ap.saveContext()
        return newTipo
    }
    
    class func getTipos()->[Tipo]?{
        let resquest = NSFetchRequest(entityName: "Tipo")
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        do{
            let tipo = try ap.managedObjectContext.executeFetchRequest(resquest) as! [Tipo]
            if let _ = tipo.first{
                return tipo
            }else{
                return nil
            }
            
        }catch {
            return nil
        }
        
    }
    
    class func getTipoByCategoria(id_categoria: NSNumber)->[Tipo]?{
        let resquest = NSFetchRequest(entityName: "Tipo")
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        let tipoSet = NSMutableSet()
        do{
            let tipos = try ap.managedObjectContext.executeFetchRequest(resquest) as! [Tipo]
            for tipo in tipos {
                if(tipo.id_categoria == id_categoria){
                    tipoSet.addObject(tipo)
                }
            }
            
        }catch {
            return nil
        }
        return tipoSet.allObjects as? [Tipo]
    }

}
