//
//  Usuario.swift
//  SERVOSA
//
//  Created by ucweb on 26/06/16.
//  Copyright © 2016 ucweb. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Usuario: NSManagedObject {
    
    class func login(email: String?, password: String?, viewcontroller: UIViewController){
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        if email?.characters.count != 0 && password?.characters.count != 0 {
            LoadingHelper().showLoading()
 
            let parameters = "username="+email!+"&password="+password!
            
            let session = NSURLSession.sharedSession()
            let request = NSMutableURLRequest(URL: NSURL(string: "http://www.uc-web.mobi/SERVOSA/api-rest/signIn")!)
            request.HTTPMethod = "POST"
            request.HTTPBody = parameters.dataUsingEncoding(NSUTF8StringEncoding)
            
            let task = session.dataTaskWithRequest(request) { (responseObject: NSData?, response: NSURLResponse?, error: NSError?) in
                if let _ = responseObject{
                    do{
                        let dic = try NSJSONSerialization.JSONObjectWithData(responseObject!, options: NSJSONReadingOptions.AllowFragments) as! [String: AnyObject]
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            LoadingHelper().hideLoading()
                            let status =  dic["status"] as! Bool
                            if status {
                                createUser(dic)
                                
                                ap.showApp()
                            }else{
                                LoadingHelper().hideLoading()
                                AlertHelper.notificationAlert("", message: "Ingrese sus datos de usuario correctamente", viewController: viewcontroller)
                            }
                            
                        })
                        
                        
                    }catch{
                        LoadingHelper().hideLoading()
                    }
                    
                }
            }
            task.resume()
            
        }else{
            
            AlertHelper.notificationAlert("", message: "Ingrese sus datos de usuario correctamente", viewController: viewcontroller)
        }
    }
    
    
    class func createUser(json: AnyObject){
        let response = json as! [String:AnyObject]
        
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let usuario = response["data"]
        
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("Usuario", inManagedObjectContext: ap.managedObjectContext) as! Usuario
        
        //Asignamos los valores
        newUser.id =  NSNumber(integer: Int((usuario!["id_usuario"] as! String))!)
        newUser.nombre = usuario!["nombre"] as? String
        newUser.apellidos = usuario!["apellidos"] as? String
        newUser.email = usuario!["email"] as? String
        newUser.tipo_usuario = usuario!["nombre_tipo_usuario"] as? String
        newUser.id_tipo_usuario = NSNumber(integer: Int((usuario!["id_tipo_usuario"] as! String))!)
        newUser.id_region = NSNumber(integer: Int((usuario!["id_region"] as! String))!)
        //Guardamos la informacion
        ap.saveContext()
        
    }
    
    class func isAvailable()->Bool{
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        let request = NSFetchRequest(entityName: "Usuario")
        
        do{
            let result = try ap.managedObjectContext.executeFetchRequest(request) as! [Usuario]
            //let result = try ap.managedObjectContext.executeFetchRequest(request) as! Array<User>
            if result.count != 0 {
                return true
            }else{
                return false
            }
        }catch{
            return false
        }
        
    }
    
    class func currentUser()->Usuario?{
        let resquest = NSFetchRequest(entityName: "Usuario")
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        do{
            let user = try ap.managedObjectContext.executeFetchRequest(resquest) as! [Usuario]
            if let _ = user.first{
                return user.first
            }else{
                return nil
            }
            
        }catch {
            return nil
        }

    }
    
    class func addOperacion(json: AnyObject)->[Operacion]{
        let operaciones = json as![AnyObject]
        let operacionSet = NSMutableSet()
        for operacion in operaciones {
            operacionSet.addObject(Operacion.createOperacion(operacion))
        }
        
        return operacionSet.allObjects as! [Operacion]
    }
    
    class func addEvento(json: AnyObject)->[Evento]{
        let operaciones = json as![AnyObject]
        let operacionSet = NSMutableSet()
        for operacion in operaciones {
            operacionSet.addObject(Evento.createEvento(operacion))
        }
        
        return operacionSet.allObjects as! [Evento]
    }
    
    
    

}
