//
//  ListadoViewController.swift
//  SERVOSA
//
//  Created by ucweb on 19/07/16.
//  Copyright © 2016 ucweb. All rights reserved.
//

import UIKit

class ListadoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let greenColor = UIColor(red: 138, green: 215, blue: 24)
    let blueColor = UIColor(red: 15, green: 55, blue: 107)
    private var registrosListado: [Listado]!
    
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoView.backgroundColor = blueColor
        registerTableViewCells()
        registrosListado = Listado.getListado()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeListado(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: TableView DataSource methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if registrosListado?.count == nil{
            return 0
        }else{
            return registrosListado.count
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("listadoCell", forIndexPath: indexPath) as! ListadoCell
        
        cell.operacion.text = "Operacion: "+registrosListado![indexPath.row].operacion!
        cell.ruta.text = "Ruta: "+registrosListado![indexPath.row].ruta!
        cell.tramo.text = "Tramo: "+registrosListado![indexPath.row].tramo!
        cell.evento.text = "Evento: "+registrosListado![indexPath.row].evento!
        cell.categoria.text = "Categoria: "+registrosListado![indexPath.row].categoria!
        cell.tipo.text = "Tipo: "+registrosListado![indexPath.row].tipo!
        cell.descripcion.text = "Descripcion: "+registrosListado![indexPath.row].descripcion!
        cell.fecha.text = registrosListado![indexPath.row].fecha
        
        return cell

        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    /*func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        openModal(indexPath.row)
    }
    
    func openModal(index: Int){
        /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let popupViewC = storyboard.instantiateViewControllerWithIdentifier("popuView") as! PopupViewController
        self.addChildViewController(popupViewC)
        popupViewC.view.frame = self.view.frame
        self.view.addSubview(popupViewC.view)
        popupViewC.didMoveToParentViewController(self)*/
        //Listado.getListadoID(index)

        self.performSegueWithIdentifier("showPopupView", sender: index)
    }
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return true
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showPopupView" {
            let nav = segue.destinationViewController as! PopupViewController
            nav.index = sender as? Int
        }
    }*/
    
    //MARK: Xib Register
    func registerTableViewCells(){
        tableView.registerNib(UINib(nibName: "ListadoCell", bundle: nil), forCellReuseIdentifier: "listadoCell")
    }
    
    
    

}
