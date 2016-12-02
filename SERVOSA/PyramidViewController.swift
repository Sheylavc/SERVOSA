//
//  PyramidViewController.swift
//  SERVOSA
//
//  Created by ucweb on 21/07/16.
//  Copyright © 2016 ucweb. All rights reserved.
//

import UIKit

class PyramidViewController: UIViewController {
    let blueColor = UIColor(red: 15, green: 55, blue: 107)
    var filtro: [String : AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoView.backgroundColor = blueColor
        getDataToPyramidChart(filtro)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var logoView: UIImageView!
    
    @IBOutlet weak var txtMuerte: UILabel!
    @IBOutlet weak var txtAccidentesPersonales: UILabel!
    @IBOutlet weak var txtAccidentesPropiedad: UILabel!
    @IBOutlet weak var txtCasiAccidentes: UILabel!
    @IBOutlet weak var txtComportamientoRiesgo: UILabel!
    
    
    
    @IBAction func closeButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func getDataToPyramidChart(filtro : [String : AnyObject]){
        
        AlertHelper.showLoadingAlert(self)
        
        var tipofiltro: String!
        var valuefiltro: NSNumber!
        for (filtrokey, filtroname) in filtro {
            tipofiltro = filtrokey
            valuefiltro = filtroname as! NSNumber
        }
        
        let userID = Usuario.currentUser()?.id
        let tipo_usuario = Usuario.currentUser()?.tipo_usuario
        let id_tipo_usuario = Usuario.currentUser()?.id_tipo_usuario
        let parameters = "tipo_usuario="+String(tipo_usuario)+"&id_tipo_usuario="+String(id_tipo_usuario as! Int)+"&filtro="+String(tipofiltro)+"&id_region="+String(valuefiltro)+"&id_operacion="+(valuefiltro.stringValue)+"&id_usuario="+(userID?.stringValue)!
        
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.uc-web.mobi/SERVOSA/api-rest/evento/getEventosPiramide")!)
        request.HTTPMethod = "POST"
        request.HTTPBody = parameters.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = session.dataTaskWithRequest(request) { (responseObject: NSData?, response: NSURLResponse?, error: NSError?) in
            if let _ = responseObject{
                do{
                    let dic = try NSJSONSerialization.JSONObjectWithData(responseObject!, options: NSJSONReadingOptions.AllowFragments) as! [String: AnyObject]

                    dispatch_async(dispatch_get_main_queue(), {
                        
                        let status =  dic["status"] as! Bool
                        AlertHelper.hideLoadingAlert(self)
                        let piramide_nivel_1: Int!
                        let piramide_nivel_2: Int!
                        let piramide_nivel_3: Int!
                        let piramide_nivel_4: Int!
                        let piramide_nivel_5: Int!
                        if status {
                            let data = dic["data"]
                            piramide_nivel_1 = data!["piramide_nivel_1"] as! Int
                            piramide_nivel_2 = data!["piramide_nivel_2"] as! Int
                            piramide_nivel_3 = data!["piramide_nivel_3"] as! Int
                            piramide_nivel_4 = data!["piramide_nivel_4"] as! Int
                            piramide_nivel_5 = data!["piramide_nivel_5"] as! Int
                            if(piramide_nivel_1 == 0 && piramide_nivel_2 == 0 && piramide_nivel_3 == 0 && piramide_nivel_4 == 0 && piramide_nivel_5 == 0){
                                AlertHelper.notificationAlert("Grafico Piramide Brid", message: "No existen eventos registrados", viewController: self)
                            }else{
                                self.txtMuerte.text = String(piramide_nivel_1)
                                self.txtAccidentesPersonales.text = String(piramide_nivel_2)
                                self.txtAccidentesPropiedad.text = String(piramide_nivel_3)
                                self.txtCasiAccidentes.text = String(piramide_nivel_4)
                                self.txtComportamientoRiesgo.text = String(piramide_nivel_5)
                            }
                            
                        }
                        
                    })
                    
                }catch{
                    AlertHelper.hideLoadingAlert(self)
                    AlertHelper.notificationAlert("Actualizacion", message: "No se ha podido obtener la informacion, intente nuevamente.", viewController: self)
                }
                
            }else{
                AlertHelper.hideLoadingAlert(self)
                AlertHelper.notificationAlert("Actualizacion", message: "No se ha podido obtener la informacion, intente nuevamente.", viewController: self)
            }
        }
        task.resume()
        
    }

}
