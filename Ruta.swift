//
//  Ruta.swift
//  SERVOSA
//
//  Created by ucweb on 14/07/16.
//  Copyright © 2016 ucweb. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Ruta: NSManagedObject {

    class func createrRuta(json: AnyObject)-> Ruta {
        
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let newRuta = NSEntityDescription.insertNewObjectForEntityForName("Ruta", inManagedObjectContext: ap.managedObjectContext) as! Ruta
        //Asignamos los valores
        newRuta.id_ruta =  NSNumber(integer: Int((json["id_ruta"] as! String))!)
        newRuta.id_operacion = NSNumber(integer: Int((json["id_operacion"] as! String))!)
        newRuta.nombre_ruta = json["nombre_ruta"] as? String
        
        //Guardamos la informacion
        ap.saveContext()
        
        return newRuta
        
    }
    
    class func addTramo(json: AnyObject)->[Tramo]{
        let tramos = json as![AnyObject]
        let tramoSet = NSMutableSet()
        for tramo in tramos {
            tramoSet.addObject(Tramo.createTramo(tramo))
        }
        //currentUser()?.usuario_operacion = tramoSet
        return tramoSet.allObjects as! [Tramo]
    }
    class func getRutas()->[Ruta]?{
        let resquest = NSFetchRequest(entityName: "Ruta")
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        do{
            let ruta = try ap.managedObjectContext.executeFetchRequest(resquest) as! [Ruta]
            if let _ = ruta.first{
                return ruta
            }else{
                return nil
            }
            
        }catch {
            return nil
        }
        
    }
    
    class func getRutasByOperacion(id_operacion: NSNumber)->[Ruta]?{
        let resquest = NSFetchRequest(entityName: "Ruta")
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        let rutaSet = NSMutableSet()
        do{
            let rutas = try ap.managedObjectContext.executeFetchRequest(resquest) as! [Ruta]
            for ruta in rutas {
                if(ruta.id_operacion == id_operacion){
                    rutaSet.addObject(ruta)
                }
            }
            
        }catch {
            return nil
        }
        return rutaSet.allObjects as? [Ruta]
    }
    
    

}
