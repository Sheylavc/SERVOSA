//
//  PopupViewController.swift
//  SERVOSA
//
//  Created by ucweb on 26/07/16.
//  Copyright © 2016 ucweb. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        //self.showAnimate()
        contenido()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var txtOperacion: UILabel!
    @IBOutlet weak var txtRuta: UILabel!
    @IBOutlet weak var txtTramo: UILabel!
    @IBOutlet weak var txtEvento: UILabel!
    @IBOutlet weak var txtCategoria: UILabel!
    @IBOutlet weak var txtTipo: UILabel!
    @IBOutlet weak var txtPlaca: UILabel!
    @IBOutlet weak var txtDescripcion: UILabel!
    @IBOutlet weak var txtFecha: UILabel!
    
    @IBAction func closeButton(sender: AnyObject) {
        //self.view.removeFromSuperview()
        self.removeAnimate()
    }
    
    func contenido(){
        let evento = Listado.getListadoID(index)
        txtOperacion.text = evento?.evento
        txtRuta.text = evento?.ruta
        txtTramo.text = evento?.tramo
        txtEvento.text = evento?.evento
        txtCategoria.text = evento?.categoria
        txtTipo.text = evento?.tipo
        txtPlaca.text = evento?.placa
        txtDescripcion.text = evento?.descripcion
        txtFecha.text = evento?.fecha
        
    }
    
    func showAnimate(){
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
        self.view.alpha = 0.0
        UIView.animateWithDuration(0.25, animations: {
           self.view.alpha = 1.0
            self.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
        });
    }
    
    func removeAnimate(){
        UIView.animateWithDuration(0.25, animations: {
            self.view.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.view.alpha = 0.0;
            },completion: {(finished: Bool) in
                if (finished){
                    //self.view.removeFromSuperview()
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            })
    }
    
    
}
