//
//  Listado.swift
//  SERVOSA
//
//  Created by ucweb on 14/07/16.
//  Copyright © 2016 ucweb. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Listado: NSManagedObject {

    class func createListado(
        viewcontroller: UIViewController,
        id_operacion: NSNumber,
        nombre_operacion: String,
        id_ruta: NSNumber,
        nombre_ruta: String,
        id_tramo: NSNumber,
        nombre_tramo: String,
        id_placa: NSNumber,
        placa: String,
        id_evento: NSNumber,
        nombre_evento: String,
        id_categoria: NSNumber,
        nombre_categoria: String,
        id_tipo: NSNumber?,
        nombre_tipo: String,
        fecha: String,
        descripcion: String,
        estado: String
        ){
        if estado == "0" { AlertHelper.showLoadingAlert(viewcontroller)}
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let newListado = NSEntityDescription.insertNewObjectForEntityForName("Listado", inManagedObjectContext: ap.managedObjectContext) as! Listado
        print(id_tipo)
        
        newListado.id_operacion = id_operacion
        newListado.operacion = nombre_operacion
        newListado.id_ruta = id_ruta
        newListado.ruta = nombre_ruta
        newListado.id_tramo = id_tramo
        newListado.tramo = nombre_tramo
        newListado.id_placa = id_placa
        newListado.placa = placa
        newListado.id_evento = id_evento
        newListado.evento = nombre_evento
        newListado.id_categoria = id_categoria
        newListado.categoria = nombre_categoria
        newListado.id_tipo = id_tipo
        newListado.tipo = nombre_tipo
        newListado.descripcion = descripcion
        newListado.fecha = fecha
        newListado.estado = estado
        ap.saveContext()
        if estado == "0" { AlertHelper.hideLoadingAlert(viewcontroller)}
        
    }
    
    class func getListado()->[Listado]?{
        let resquest = NSFetchRequest(entityName: "Listado")
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        do{
            let listado = try ap.managedObjectContext.executeFetchRequest(resquest) as! [Listado]
            if let _ = listado.first{
                return listado
            }else{
                return nil
            }
            
        }catch {
            return nil
        }
        
    }
    
    class func getListadoID(index: Int)->Listado?{
        let resquest = NSFetchRequest(entityName: "Listado")
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        do{
            let listado = try ap.managedObjectContext.executeFetchRequest(resquest) as! [Listado]
            if listado.count > 0{
                for evento in listado {
                    if evento.objectID == index{
                        return evento
                    }
                }
            }else{
                return nil
            }
            
        }catch {
            return nil
        }
        return nil
    }
    
    class func saveListadoPendiente(viewcontroller: UIViewController){
        let resquest = NSFetchRequest(entityName: "Listado")
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        do{
            let listado = try ap.managedObjectContext.executeFetchRequest(resquest) as! [Listado]
            if listado.count > 0{
                for evento in listado {

                    if(evento.estado == "0"){
                       
                        ModelHelper.saveEventoRiesgo(viewcontroller, id_operacion: evento.id_operacion!, id_ruta: evento.id_ruta!, id_tramo: evento.id_tramo!, id_placa: evento.id_placa!, id_evento: evento.id_evento!, id_categoria: evento.id_categoria!, id_tipo: evento.id_tipo!, fecha: evento.fecha!, descripcion: evento.descripcion!)
                        evento.estado = "1"
                        ap.saveContext()
                    }else{
                        //AlertHelper.notificationAlert("Evento de Riesgo", message: "No existen eventos pendientes por regitrar", viewController: viewcontroller)
                    }
                }
                
            }else{
                //AlertHelper.notificationAlert("Evento de Riesgo", message: "No existen eventos pendientes por regitrar", viewController: viewcontroller)
            }
            
            
        }catch {

        }
        
    }

}
