//
//  LoginViewController.swift
//  SERVOSA
//
//  Created by ucweb on 26/06/16.
//  Copyright © 2016 ucweb. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, UITextFieldDelegate{

    private var lastContentOffset: CGFloat = 0
   
    
    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //txtUsuario.delegate = self
        //txtPassword.delegate = self
      
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Outlets methods
    
    @IBOutlet weak var txtUsuario: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var scrollview: UIScrollView!

    

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.tag == 0 {
            txtPassword.becomeFirstResponder()
        }else if textField.tag == 1{
            txtPassword.resignFirstResponder()
        }
        return true
    }
    
   
    
    func textFieldDidEndEditing(textField: UITextField) {
        scrollview.setContentOffset(CGPointMake(0, 0), animated: true)
        if textField == txtPassword {

            if txtPassword.text?.characters.count != 0 {
                if Reachability.isConnectedToNetwork() {
                    Usuario.login(self.txtUsuario.text!, password: self.txtPassword.text!, viewcontroller: self)
                }else{
                    AlertHelper.notificationAlert("Conexion a Internet", message: "Debe activar o verificar su estado de conexion a internet", viewController: self)
                }
            }
            
            
        }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        switch textField.tag {
        case 0...1:
            break
        default:
            scrollview.setContentOffset(CGPointMake(0, 100), animated: true)
        }
    }
    
    

}
