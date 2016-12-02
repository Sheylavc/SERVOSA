//
//  Operacion.swift
//  SERVOSA
//
//  Created by ucweb on 14/07/16.
//  Copyright © 2016 ucweb. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Operacion: NSManagedObject {

    /*class func runRutas(json: AnyObject)->Operacion?{
        
        let resquest = NSFetchRequest(entityName: "Operacion")
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        do{
            let operaciones = try ap.managedObjectContext.executeFetchRequest(resquest) as! [Operacion]
            for operacion in operaciones {
               addRutas(json, idOperacion: operacion.id_operacion!)
            }
            
        }catch {
            return nil
        }
        return nil
    }*/
    
    class func currentOperacion(idOperacion: NSNumber)->Operacion?{
        
        let resquest = NSFetchRequest(entityName: "Operacion")
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        do{
            let operaciones = try ap.managedObjectContext.executeFetchRequest(resquest) as! [Operacion]
            for operacion in operaciones {
                if( operacion.id_operacion == idOperacion){
                 return operacion
                }else{
                 return nil
                }
            }
            
        }catch {
            return nil
        }
        return nil
    }
    
    class func createOperacion(json: AnyObject)-> Operacion {
        
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
    
        let newOperacion = NSEntityDescription.insertNewObjectForEntityForName("Operacion", inManagedObjectContext: ap.managedObjectContext) as! Operacion
        //Asignamos los valores
        newOperacion.id_operacion =  NSNumber(integer: Int((json["id_operacion"] as! String))!)
        newOperacion.id_region = NSNumber(integer: Int((json["id_region"] as! String))!)
        newOperacion.nombre_operacion = json["nombre_operacion"] as? String

        //Guardamos la informacion
        ap.saveContext()
        return newOperacion
        
    }
    
    class func addRutas(json: AnyObject)->[Ruta]{
        let rutas = json as![AnyObject]
        //print(rutas)
        let rutaSet = NSMutableSet()
        //print(idOperacion.stringValue)
        
        for ruta in rutas {
            rutaSet.addObject(Ruta.createrRuta(ruta))
            
        }
        //currentOperacion(idOperacion)?.operacion_ruta = rutaSet
        return rutaSet.allObjects as! [Ruta]
    }
    class func addPlacas(json: AnyObject)->[Placa]{
        let placas = json as![AnyObject]
        let placaSet = NSMutableSet()
        for placa in placas {
            placaSet.addObject(Placa.createPlaca(placa))
        }
        return placaSet.allObjects as! [Placa]
    }
    
    class func getOperaciones()->[Operacion]?{
        let resquest = NSFetchRequest(entityName: "Operacion")
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        do{
            let operacion = try ap.managedObjectContext.executeFetchRequest(resquest) as! [Operacion]
            if let _ = operacion.first{
                return operacion
            }else{
                return nil
            }
            
        }catch {
            return nil
        }
        
    }

}
