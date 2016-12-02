//
//  Placa.swift
//  SERVOSA
//
//  Created by ucweb on 14/07/16.
//  Copyright © 2016 ucweb. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Placa: NSManagedObject {

    class func createPlaca(json: AnyObject)-> Placa {
        
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let newPlaca = NSEntityDescription.insertNewObjectForEntityForName("Placa", inManagedObjectContext: ap.managedObjectContext) as! Placa
        //Asignamos los valores
        newPlaca.id_placa =  NSNumber(integer: Int((json["id_placa"] as! String))!)
        newPlaca.id_operacion = NSNumber(integer: Int((json["id_operacion"] as! String))!)
        newPlaca.placa = json["placa"] as? String
        
        //Guardamos la informacion
        ap.saveContext()
        return newPlaca
        
    }
    
    class func getPlacas()->[Placa]?{
        let resquest = NSFetchRequest(entityName: "Placa")
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        do{
            let placa = try ap.managedObjectContext.executeFetchRequest(resquest) as! [Placa]
            if let _ = placa.first{
                return placa
            }else{
                return nil
            }
            
        }catch {
            return nil
        }
        
    }
    
    class func getPlacasByOperacion(id_operacion: NSNumber)->[Placa]?{
        let resquest = NSFetchRequest(entityName: "Placa")
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        let placaSet = NSMutableSet()
        do{
            let placas = try ap.managedObjectContext.executeFetchRequest(resquest) as! [Placa]

            for placa in placas {
                if(placa.id_operacion == id_operacion){
                    placaSet.addObject(placa)
                }
            }
            
        }catch {
            return nil
        }
        return placaSet.allObjects as? [Placa]
    }

}
