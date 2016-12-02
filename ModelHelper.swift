//
//  ModelHelper.swift
//  SERVOSA
//
//  Created by ucweb on 18/07/16.
//  Copyright © 2016 ucweb. All rights reserved.
//

import UIKit
import CoreData

class ModelHelper: NSObject {
    class func deleteOperaciones() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let coord = app.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest(entityName: "Operacion")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coord.executeRequest(deleteRequest, withContext: context)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    class func deleteRutas() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let coord = app.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest(entityName: "Ruta")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coord.executeRequest(deleteRequest, withContext: context)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    class func deleteTramos() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let coord = app.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest(entityName: "Tramo")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coord.executeRequest(deleteRequest, withContext: context)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    class func deleteEventos() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let coord = app.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest(entityName: "Evento")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coord.executeRequest(deleteRequest, withContext: context)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    class func deleteCategorias() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let coord = app.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest(entityName: "Categoria")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coord.executeRequest(deleteRequest, withContext: context)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    class func deleteTipos() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let coord = app.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest(entityName: "Tipo")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coord.executeRequest(deleteRequest, withContext: context)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    class func deletePlacas() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let coord = app.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest(entityName: "Placa")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coord.executeRequest(deleteRequest, withContext: context)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    class func deleteListado() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let coord = app.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest(entityName: "Listado")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coord.executeRequest(deleteRequest, withContext: context)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    class func deleteUsuario() {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        let coord = app.persistentStoreCoordinator
        
        let fetchRequest = NSFetchRequest(entityName: "Usuario")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coord.executeRequest(deleteRequest, withContext: context)
        } catch let error as NSError {
            debugPrint(error)
        }
    }
    
    class func getRegistros(viewcontroller : UIViewController){
        let userID = Usuario.currentUser()
        
        AlertHelper.showLoadingAlert(viewcontroller)
        let parameters = "id_usuario="+(userID?.id?.stringValue)!
        
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.uc-web.mobi/SERVOSA/api-rest/evento/getAllData")!)
        request.HTTPMethod = "POST"
        request.HTTPBody = parameters.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = session.dataTaskWithRequest(request) { (responseObject: NSData?, response: NSURLResponse?, error: NSError?) in
            if let _ = responseObject{
                do{
                    let dic = try NSJSONSerialization.JSONObjectWithData(responseObject!, options: NSJSONReadingOptions.AllowFragments) as! [String: AnyObject]
                    
                    let data = dic["data"] as! [String: AnyObject]
                    
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        Usuario.addOperacion(data["dataOperaciones"]!)
                        Operacion.addRutas(data["dataRutas"]!)
                        Ruta.addTramo(data["dataTramos"]!)
                        Operacion.addPlacas(data["dataPlacas"]!)
                        Usuario.addEvento(data["dataEventos"]!)
                        Evento.addCategoria(data["dataCategorias"]!)
                        Categoria.addTipo(data["dataTipos"]!)
                        AlertHelper.hideLoadingAlert(viewcontroller)
                        AlertHelper.notificationAlert("Actualizacion", message: "La informacion se ha actualizado correctamente", viewController: viewcontroller)
                    })
                    
                    
                    
                }catch{

                    AlertHelper.hideLoadingAlert(viewcontroller)
                    AlertHelper.notificationAlert("Actualizacion", message: "No se ha podido actualizar la informacion, intente nuevamente.", viewController: viewcontroller)
                }
                
            }else{
                AlertHelper.hideLoadingAlert(viewcontroller)
            }
        }
        task.resume()
    }
    
    class func deleteRecords(){
        deleteEventos()
        deleteCategorias()
        deleteTipos()
        deletePlacas()
        deleteOperaciones()
        deleteRutas()
        deleteTramos()
    }
    
    class func saveEventoRiesgo(viewcontroller : UIViewController,
                                id_operacion: NSNumber,
                                id_ruta: NSNumber,
                                id_tramo: NSNumber,
                                id_placa: NSNumber,
                                id_evento: NSNumber,
                                id_categoria: NSNumber,
                                id_tipo: NSNumber,
                                fecha: String,
                                descripcion: String

                                ){
        AlertHelper.showLoadingAlert(viewcontroller)
        
        let userID = Usuario.currentUser()
        
        let parameters = "id_evento="+String(id_evento as Int)+"&id_categoria="+String(id_categoria as Int)+"&id_tipo="+String(id_tipo as Int)+"&id_placa="+String(id_placa as Int)+"&id_tramo="+String(id_tramo as Int)+"&descripcion="+descripcion+"&fecha_registro="+fecha+"&id_usuario="+(userID?.id?.stringValue)!
     
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.uc-web.mobi/SERVOSA/api-rest/evento/registrarEventos")!)
        request.HTTPMethod = "POST"
        request.HTTPBody = parameters.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = session.dataTaskWithRequest(request) { (responseObject: NSData?, response: NSURLResponse?, error: NSError?) in
            if let _ = responseObject{
                do{
                    let dic = try NSJSONSerialization.JSONObjectWithData(responseObject!, options: NSJSONReadingOptions.AllowFragments) as! [String: AnyObject]
                    
                    print(dic)
                    dispatch_async(dispatch_get_main_queue(), {

                        let status =  dic["status"] as! Bool
                        AlertHelper.hideLoadingAlert(viewcontroller)
                        if status {
                            AlertHelper.notificationAlert("Evento de Riesgo", message: "La informacion ha sido guardada correctamente", viewController: viewcontroller)
                        }
                        
                    })
                    
                }catch{
                    AlertHelper.hideLoadingAlert(viewcontroller)
                    AlertHelper.notificationAlert("Actualizacion", message: "No se ha podido guardar la informacion, intente nuevamente.", viewController: viewcontroller)
                }
                
            }else{
                AlertHelper.hideLoadingAlert(viewcontroller)
            }
        }
        task.resume()
    }
    
    
}
