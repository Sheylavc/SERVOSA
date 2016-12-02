//
//  ConfiguracionViewController.swift
//  SERVOSA
//
//  Created by ucweb on 25/07/16.
//  Copyright © 2016 ucweb. All rights reserved.
//

import UIKit
import MessageUI

class ConfiguracionViewController: UIViewController, MFMailComposeViewControllerDelegate {
    let blueColor = UIColor(red: 15, green: 55, blue: 107)
    var filtro: [String : AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoView.backgroundColor = blueColor
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            
    }
    
    @IBOutlet weak var logoView: UIImageView!
    
    @IBOutlet weak var actualizarSwitch: UISwitch!
    @IBOutlet weak var notificarSwitch: UISwitch!
    
    
    @IBAction func closeButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
   
    @IBAction func actualizarAction(sender: AnyObject) {
        
        let onState = actualizarSwitch.on
        
        if onState {
            if Reachability.isConnectedToNetwork(){
                ModelHelper.deleteRecords()
                ModelHelper.getRegistros(self)
                Listado.saveListadoPendiente(self)
            }else{
                AlertHelper.notificationAlert("Conexion a Internet", message: "Debe activar o verificar su estado de conexion a internet", viewController: self)
            }
            
        }
    }
    
    @IBAction func notificarAction(sender: AnyObject) {
        let onState = notificarSwitch.on
        if onState {
            if Reachability.isConnectedToNetwork(){
                showSendMail()
            }else{
                AlertHelper.notificationAlert("Conexion a Internet", message: "Debe activar o verificar su estado de conexion a internet", viewController: self)
            }
            
        }
    }
    
    func configureMailComposeViewController()->MFMailComposeViewController{
        let user = Usuario.currentUser()
        let nombre = (user?.nombre!)! + " " + (user?.apellidos!)!

        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["mpalomino@servosa.pe"])
        mailComposerVC.setSubject("NOTIFICACION DE ERROR EN APP")
        mailComposerVC.setMessageBody("Usuario:\n"+nombre+"\nCorreo Electronico:\n"+(user?.email!)!+"\nNotifico error en aplicacion movil", isHTML: false)
        return mailComposerVC
    }
    
    func showSendMail() {
        let mailComposeViewController = configureMailComposeViewController()
        if MFMailComposeViewController.canSendMail(){
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        }
        /*else{
            AlertHelper.notificationAlert("No se pudo enviar el Email", message: "Tu dispositivo no pudo enviar el mensaje. Porfavor revise la configuracion de email e intente nuevamente.", viewController: self)
        }*/
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        /*switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            closeAfterCancel()
            break
        case MFMailComposeResultSent.rawValue:
            closeAfterSend()
            break
        default:
            break
        }*/
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
