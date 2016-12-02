//
//  AlertHelper.swift
//  SERVOSA
//
//  Created by ucweb on 12/07/16.
//  Copyright © 2016 ucweb. All rights reserved.
//

import UIKit

class AlertHelper: NSObject {
   
    
    //MARK: Simple Notification Alert
    class func notificationAlert(title: String, message:String, viewController : UIViewController) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let successAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            NSLog("OK Pressed")
        }
        
        alertController.addAction(successAction)
        
        viewController.presentViewController(alertController, animated: true, completion:nil)
    }
    //MARK: Notification Alert with Options
    class func notificationAlertwithOptions(title: String, message:String, viewController : UIViewController) {
        
        //Create alert Controller _> title, message, style
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        //Create button Action -> title, style, action
        let successAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            NSLog("OK Pressed")
        }
        
        alertController.addAction(successAction)
        
        viewController.presentViewController(alertController, animated: true, completion:nil)
    }
    
    //MARK: Loading Notification Alert
    class func showLoadingAlert(viewController : UIViewController){
        let alert = UIAlertController(title: nil, message: "Espere un momento...", preferredStyle: .Alert)
        
        alert.view.tintColor = UIColor.blackColor()
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(10, 5, 50, 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
    
    class func hideLoadingAlert(viewController : UIViewController){
        viewController.dismissViewControllerAnimated(false, completion: nil)
    }
   
    //MARK: Display Alert to choise options of graphics
    class func openPresentacionDatos(datos: [String], titulo: String, mensaje: String, viewcontroller: UIViewController){
        
        let alertController = UIAlertController(title: titulo, message: mensaje, preferredStyle: .Alert)
        
        for array in datos {
            let btn = UIAlertAction(title: array, style: .Default) { action -> Void in
                alertController.dismissViewControllerAnimated(true, completion: nil)
                filtroGerente(array, viewcontroller: viewcontroller)
            }
            alertController.addAction(btn)
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .Cancel) { (_) in }
        alertController.addAction(cancelAction)
        viewcontroller.presentViewController(alertController, animated: true, completion: nil)
    }
    
    class func openPresentacionTipoDatos(datos: [String], titulo: String, mensaje: String, viewcontroller: UIViewController, grafico: Int ){
        let alertController = UIAlertController(title: titulo, message: mensaje, preferredStyle: .Alert)
        
        for array in datos {
            let btn = UIAlertAction(title: array, style: .Default) { action -> Void in
                alertController.dismissViewControllerAnimated(true, completion: nil)
                showView(viewcontroller, grafico: grafico, tipo: array)
            }
            alertController.addAction(btn)
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .Cancel) { (_) in }
        alertController.addAction(cancelAction)
        viewcontroller.presentViewController(alertController, animated: true, completion: nil)
    }
    
    class func openRegion(datos: [Int: String], titulo: String, mensaje: String, viewcontroller: UIViewController, grafico: Int ){
        let alertController = UIAlertController(title: titulo, message: mensaje, preferredStyle: .Alert)
        
        for (arraycode, arrayname) in datos {
            let btn = UIAlertAction(title: arrayname, style: .Default) { action -> Void in
                alertController.dismissViewControllerAnimated(true, completion: nil)
                showAlertRegion(viewcontroller, grafico: grafico, tiponame: arrayname, tipocode: arraycode)
            }
            alertController.addAction(btn)
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .Cancel) { (_) in }
        alertController.addAction(cancelAction)
        viewcontroller.presentViewController(alertController, animated: true, completion: nil)
    }
    
    class func openOperacion(datos: [Operacion], titulo: String, mensaje: String, viewcontroller: UIViewController, grafico: Int ){
        let alertController = UIAlertController(title: titulo, message: mensaje, preferredStyle: .Alert)
        
        for dato in datos {
            let btn = UIAlertAction(title: dato.nombre_operacion, style: .Default) { action -> Void in
                alertController.dismissViewControllerAnimated(true, completion: nil)
                showAlertOperacion(viewcontroller, grafico: grafico, tiponame: dato.nombre_operacion!, tipocode: dato.id_operacion!)
            }
            alertController.addAction(btn)
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .Cancel) { (_) in }
        alertController.addAction(cancelAction)
        viewcontroller.presentViewController(alertController, animated: true, completion: nil)
    }
    
    class func filtroGerente(caso: String, viewcontroller: UIViewController){
        let tipoPresentacionDatosGerente: [String] = ["Grafico Nacional", "Grafico Regional", "Grafico por Operacion"]
        let tipoPresentacionDatosGerente_: [String] = ["Reporte Nacional", "Reporte Regional", "Reporte por Operacion"]
        let tipoPresentacionDatosSupervisor: [String] = ["Grafico Regional", "Grafico por Operacion"]
        let tipoPresentacionDatosSupervisor_: [String] = ["Reporte Regional", "Reporte por Operacion"]
        let user = Usuario.currentUser()?.id_tipo_usuario!
        
        switch caso {
        case "Grafico Piramide Brid":
            if user == 1 {
                self.openPresentacionTipoDatos(tipoPresentacionDatosSupervisor, titulo: caso, mensaje: "Seleccione una opcion", viewcontroller: viewcontroller, grafico: 1 )
            }else if user == 2{
                self.openPresentacionTipoDatos(tipoPresentacionDatosGerente, titulo: caso, mensaje: "Seleccione una opcion", viewcontroller: viewcontroller, grafico: 1)
            }
            
            break
            
        case "Grafico Comportamiento Seguro":
            if user == 1 {
                self.openPresentacionTipoDatos(tipoPresentacionDatosSupervisor, titulo: caso, mensaje: "Seleccione una opcion", viewcontroller: viewcontroller, grafico: 2)
            }else if user == 2{
                self.openPresentacionTipoDatos(tipoPresentacionDatosGerente, titulo: caso, mensaje: "Seleccione una opcion", viewcontroller: viewcontroller, grafico: 2)
            }
            break
       
        case "Reporte Comportamiento Seguro":
            if user == 1 {
                self.openPresentacionTipoDatos(tipoPresentacionDatosSupervisor_, titulo: caso, mensaje: "Seleccione una opcion", viewcontroller: viewcontroller, grafico: 3)
            }else if user == 2{
                self.openPresentacionTipoDatos(tipoPresentacionDatosGerente_, titulo: caso, mensaje: "Seleccione una opcion", viewcontroller: viewcontroller, grafico: 3)
            }
            break
        case "Reporte Piramide Brid":
            if user == 1 {
                self.openPresentacionTipoDatos(tipoPresentacionDatosSupervisor_, titulo: caso, mensaje: "Seleccione una opcion", viewcontroller: viewcontroller, grafico: 4)
            }else if user == 2{
                self.openPresentacionTipoDatos(tipoPresentacionDatosGerente_, titulo: caso, mensaje: "Seleccione una opcion", viewcontroller: viewcontroller, grafico: 4)
            }
            break
        default:
            break
        }
    }
    
    class func showView(viewcontroller: UIViewController,grafico: Int, tipo: String){
        let user = Usuario.currentUser()?.id_tipo_usuario!
        let region = Usuario.currentUser()?.id_region
        let listaoperaciones:[Operacion]? = Operacion.getOperaciones()
        

        let regionGerente: [Int: String] = [1: "Sur", 2: "Norte", 3: "Centro"]
        let regionSupervisor: [Int: String]
        
 
        switch tipo {
        case "Grafico Nacional":
            if user == 2 {
                let parameters: [String : AnyObject] = ["nacional": 1]
                if grafico == 1{
                    viewcontroller.performSegueWithIdentifier("graficosPyramid", sender: parameters)
                }else if grafico == 2{
                    viewcontroller.performSegueWithIdentifier("graficosPie", sender: parameters)
                }

            }else{
               AlertHelper.notificationAlert("Opcion no permitida", message: "Su cuenta no permite acceder a estar opcion", viewController: viewcontroller)
            }
            break
        case "Grafico Regional":
            if user == 2 {
                openRegion(regionGerente, titulo: "Grafico Regional", mensaje: "Seleccione una region", viewcontroller: viewcontroller, grafico: grafico)
            }else{
                if region == 1{
                    regionSupervisor = [ 1: "Sur"]
                }else if region == 2{
                    regionSupervisor = [ 2: "Norte"]
                }else {
                    regionSupervisor = [ 3: "Centro"]
                }

                openRegion(regionSupervisor, titulo: "Grafico Regional", mensaje: "Seleccione una region", viewcontroller: viewcontroller, grafico: grafico)
            }
            break
        case "Grafico por Operacion":
            if listaoperaciones?.count == nil {
                AlertHelper.notificationAlert("No hay registros de operaciones", message: "Actualice los datos para poder acceder a esta opcion", viewController: viewcontroller)
            }else{
               openOperacion(listaoperaciones!, titulo: "Grafico por Operacion", mensaje: "Seleccione una operacion", viewcontroller: viewcontroller, grafico: grafico)
            }
            break
        case "Reporte Nacional":
            if user == 2 {
                let parameters: [String : AnyObject] = ["nacional": 1]
                if grafico == 3{
                    viewcontroller.performSegueWithIdentifier("exportarEventosPie", sender: parameters)
                }else if grafico == 4{
                    viewcontroller.performSegueWithIdentifier("exportarEventosPyramid", sender: parameters)
                }
                
            }else{
                AlertHelper.notificationAlert("Opcion no permitida", message: "Su cuenta no permite acceder a estar opcion", viewController: viewcontroller)
            }
            break
        case "Reporte Regional":
            if user == 2 {
                openRegion(regionGerente, titulo: "Reporte Regional", mensaje: "Seleccione una region", viewcontroller: viewcontroller, grafico: grafico)
            }else{
                if region == 1{
                    regionSupervisor = [ 1: "Sur"]
                }else if region == 2{
                    regionSupervisor = [ 2: "Norte"]
                }else {
                    regionSupervisor = [ 3: "Centro"]
                }
                
                openRegion(regionSupervisor, titulo: "Reporte Regional", mensaje: "Seleccione una region", viewcontroller: viewcontroller, grafico: grafico)
            }
            break
        case "Reporte por Operacion":
            if listaoperaciones?.count == nil {
                AlertHelper.notificationAlert("No hay registros de operaciones", message: "Actualice los datos para poder acceder a esta opcion", viewController: viewcontroller)
            }else{
                openOperacion(listaoperaciones!, titulo: "Grafico por Operacion", mensaje: "Seleccione una operacion", viewcontroller: viewcontroller, grafico: grafico)
            }
            break
            
        default:
            break
        }
        
    }
    
    class func showAlertRegion(viewcontroller: UIViewController, grafico: Int, tiponame: String, tipocode: Int){
        
        let parameters: [String : AnyObject] = ["region": tipocode]
        
        if grafico == 1{
            viewcontroller.performSegueWithIdentifier("graficosPyramid", sender: parameters)
        }else if grafico == 2{
            viewcontroller.performSegueWithIdentifier("graficosPie", sender: parameters)
        }else if grafico == 3{
            viewcontroller.performSegueWithIdentifier("exportarEventosPie", sender: parameters)
        }else if grafico == 4{
            viewcontroller.performSegueWithIdentifier("exportarEventosPyramid", sender: parameters)
        }
        
        
    }
    
    class func showAlertOperacion(viewcontroller: UIViewController, grafico: Int, tiponame: String, tipocode: NSNumber){
        let parameters: [String : AnyObject] = ["operacion": tipocode]
        
        if grafico == 1{
            viewcontroller.performSegueWithIdentifier("graficosPyramid", sender: parameters)
        }else if grafico == 2{
            viewcontroller.performSegueWithIdentifier("graficosPie", sender: parameters)
        }else if grafico == 3{
            viewcontroller.performSegueWithIdentifier("exportarEventosPie", sender: parameters)
        }else if grafico == 4{
            viewcontroller.performSegueWithIdentifier("exportarEventosPyramid", sender: parameters)
        }
        
        
    }
    
    
    
    
}
