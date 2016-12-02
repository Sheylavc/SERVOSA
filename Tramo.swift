//
//  Tramo.swift
//  SERVOSA
//
//  Created by ucweb on 14/07/16.
//  Copyright © 2016 ucweb. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Tramo: NSManagedObject {

    class func createTramo(json:  AnyObject)->Tramo{
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let newTramo = NSEntityDescription.insertNewObjectForEntityForName("Tramo", inManagedObjectContext: ap.managedObjectContext) as! Tramo
        
        newTramo.id_tramo = NSNumber(integer: Int(json["id_tramo"] as! String)!)
        newTramo.id_ruta = NSNumber(integer: Int(json["id_ruta"] as! String)!)
        newTramo.nombre_tramo = json["nombre_tramo"] as? String
        ap.saveContext()
        return newTramo
    }
    
    class func getTramos()->[Tramo]?{
        let resquest = NSFetchRequest(entityName: "Tramo")
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        do{
            let tramo = try ap.managedObjectContext.executeFetchRequest(resquest) as! [Tramo]
            if let _ = tramo.first{
                return tramo
            }else{
                return nil
            }
            
        }catch {
            return nil
        }
        
    }
    
    class func getTramoByRuta(id_ruta: NSNumber)->[Tramo]?{
        let resquest = NSFetchRequest(entityName: "Tramo")
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        let tramoSet = NSMutableSet()
        do{
            let tramos = try ap.managedObjectContext.executeFetchRequest(resquest) as! [Tramo]
            for tramo in tramos {
                if(tramo.id_ruta == id_ruta){
                    tramoSet.addObject(tramo)
                }
            }
            
        }catch {
            return nil
        }
        return tramoSet.allObjects as? [Tramo]
    }
    
    
}
