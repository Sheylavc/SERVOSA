//
//  PieViewController.swift
//  SERVOSA
//
//  Created by ucweb on 20/07/16.
//  Copyright © 2016 ucweb. All rights reserved.
//

import UIKit

class PieViewController: UIViewController, PiechartDelegate {
    
    let blueColor = UIColor(red: 15, green: 55, blue: 107)
    let redColor = UIColor(red: 175, green: 32, blue: 32)
    var filtro: [String : AnyObject]!
    
    @IBAction func claseButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBOutlet weak var logoView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoView.backgroundColor = blueColor
        
        getDataToPieChart(filtro)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setSubtitle(total: CGFloat, slice: Piechart.Slice) -> String {
        return "\(Int(slice.value / total * 100))% \(slice.text)"
    }
    
    func setInfo(total: CGFloat, slice: Piechart.Slice) -> String {
        return "\(Int(slice.value))/\(Int(total))"
    }
    
    func getDataToPieChart(filtro : [String : AnyObject]){
        
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
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.uc-web.mobi/SERVOSA/api-rest/evento/getEventosComportamientoSeguro")!)
        request.HTTPMethod = "POST"
        request.HTTPBody = parameters.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = session.dataTaskWithRequest(request) { (responseObject: NSData?, response: NSURLResponse?, error: NSError?) in
            if let _ = responseObject{
                do{
                    let dic = try NSJSONSerialization.JSONObjectWithData(responseObject!, options: NSJSONReadingOptions.AllowFragments) as! [String: AnyObject]

                    dispatch_async(dispatch_get_main_queue(), {
                        
                        let status =  dic["status"] as! Bool
                        AlertHelper.hideLoadingAlert(self)
                        let comportamientoriesgo: Int!
                        let comportamientoseguro: Int!
                        if status {
                            let data = dic["data"]
                            comportamientoriesgo = data!["comportamiento_riesgo"] as! Int
                            comportamientoseguro = data!["comportamiento_seguro"] as! Int
                            if(comportamientoriesgo == 0 && comportamientoseguro == 0){
                               AlertHelper.notificationAlert("Grafico Comportamiento Seguro", message: "No existen eventos registrados", viewController: self)
                            }else{
                                self.drawPieChart(comportamientoriesgo, seguro: comportamientoseguro)
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
    
    func drawPieChart(riesgo: Int, seguro: Int){
        var views: [String: UIView] = [:]
        
        var error = Piechart.Slice()
        error.value = CGFloat(riesgo)
        error.color = blueColor
        error.text = "C. Riesgo"
        
        var zero = Piechart.Slice()
        zero.value = CGFloat(seguro)
        zero.color = redColor
        zero.text = "C. Seguro"
        
        
        let piechart = Piechart()
        piechart.delegate = self
        piechart.title = "Servosa"
        piechart.activeSlice = 0
        piechart.layer.borderWidth = 0
        piechart.slices = [error, zero]
        
        piechart.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(piechart)
        views["piechart"] = piechart
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[piechart]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-140-[piechart(==300)]", options: [], metrics: nil, views: views))
    }


}
