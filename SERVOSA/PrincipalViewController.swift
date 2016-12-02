//
//  PrincipalViewController.swift
//  SERVOSA
//
//  Created by ucweb on 22/06/16.
//  Copyright © 2016 ucweb. All rights reserved.
//

import UIKit
import CoreData
import ImageSlideshow

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
class PrincipalViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: Start var and let
    let greenColor = UIColor(red: 123, green: 181, blue: 30)
    let blueColor = UIColor(red: 15, green: 55, blue: 107)
    var presentacionGrafico: [String] = ["Grafico Piramide Brid", "Grafico Comportamiento Seguro"]
    var presentacionReporte: [String] = ["Reporte Piramide Brid", "Reporte Comportamiento Seguro"]
    
    private let namesArray : [String] = ["NUEVO EVENTO", "LISTADO DE EVENTOS", "GRAFICOS ESTADISTICOS", "EXPORTAR RESUMENES", "ACTUALIZAR", "CONFIGURAR", "CERRAR SESION"]
    var transitionDelegate: ZoomAnimatedTransitioningDelegate?
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewText: UIView!
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var slideshow: ImageSlideshow!
    
    
    
    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCells()
        viewText.backgroundColor = greenColor
        logoView.backgroundColor = blueColor
        
        imageSlide()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: TableView DataSource methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0){
            
            let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as! ItemCell
            cell.imagenView.image = UIImage(named: "icon_menu_evento.png")
            cell.label.text = namesArray[indexPath.row]
            return cell
            
        }else if(indexPath.row == 1){
            let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as! ItemCell
            cell.imagenView.image = UIImage(named: "icon_menu_lista_eventos.png")
            cell.label.text = namesArray[indexPath.row]
            return cell

        }else if(indexPath.row == 2){
            let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as! ItemCell
            cell.imagenView.image = UIImage(named: "icon_menu_estadisticas.png")
            cell.label.text = namesArray[indexPath.row]
            return cell
        }else if(indexPath.row == 3){
            let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as! ItemCell
            cell.imagenView.image = UIImage(named: "icon_menu_exportar.png")
            cell.label.text = namesArray[indexPath.row]
            return cell
        }else if(indexPath.row == 4){
            let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as! ItemCell
            cell.imagenView.image = UIImage(named: "icon_menu_actualizar.png")
            cell.label.text = namesArray[indexPath.row]
            return cell
        }else if(indexPath.row == 5){
            let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as! ItemCell
            cell.imagenView.image = UIImage(named: "icon_menu_configurar.png")
            cell.label.text = namesArray[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as! ItemCell
            cell.imagenView.image = UIImage(named: "icon_menu_cerrar.png")
            cell.label.text = namesArray[indexPath.row]
            return cell
        }
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    //MARK: Xib Register
    func registerTableViewCells(){
        tableView.registerNib(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "itemCell")
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        return true
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "nuevoEvento" {
            let nav = segue.destinationViewController as! UINavigationController
            nav.topViewController as! NewEventViewController
        }
        if segue.identifier == "graficosPyramid"{
            let nav = segue.destinationViewController as! UINavigationController
            let dc = nav.topViewController as! PyramidViewController
            
            dc.filtro = sender as? [String : AnyObject]!
            
        }
        if segue.identifier == "graficosPie"{
            let nav = segue.destinationViewController as! UINavigationController
            let dc = nav.topViewController as! PieViewController
            
            dc.filtro = sender as? [String : AnyObject]!
            
        }
        if segue.identifier == "exportarEventosPie"{
            let nav = segue.destinationViewController as! UINavigationController
            let dc = nav.topViewController as! ExportarViewController
            
            dc.filtro = sender as? [String : AnyObject]!
            
        }
        if segue.identifier == "exportarEventosPyramid"{
            let nav = segue.destinationViewController as! UINavigationController
            let dc = nav.topViewController as! ExportarPyramidViewController
            
            dc.filtro = sender as? [String : AnyObject]!
            
        }
        
        
    }

    
    //MARK: UITableViewDelegate method
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row == 0){
            loadData()
    
        }else if(indexPath.row == 1){
            
            self.performSegueWithIdentifier("listadoEventos", sender: nil)

        }else if(indexPath.row == 2){
            if Reachability.isConnectedToNetwork(){
                AlertHelper.openPresentacionDatos(presentacionGrafico, titulo: "Graficos Estadisticos", mensaje: "Seleccione una Opcion", viewcontroller: self)
            }else{
                AlertHelper.notificationAlert("Conexion a Internet", message: "Debe activar o verificar su estado de conexion a internet", viewController: self)
            }
            
        }else if(indexPath.row == 3){
            
            if Reachability.isConnectedToNetwork(){
                AlertHelper.openPresentacionDatos(presentacionReporte, titulo: "Exportar Resumenes", mensaje: "Seleccione una Opcion", viewcontroller: self)
            }else{
                AlertHelper.notificationAlert("Conexion a Internet", message: "Debe activar o verificar su estado de conexion a internet", viewController: self)
            }
            
        }else if(indexPath.row == 4){
            
            if Reachability.isConnectedToNetwork(){
                ModelHelper.deleteRecords()
                ModelHelper.getRegistros(self)
                Listado.saveListadoPendiente(self)
            }else{
                AlertHelper.notificationAlert("Conexion a Internet", message: "Debe activar o verificar su estado de conexion a internet", viewController: self)
            }
            
        }else if(indexPath.row == 5){
            
            self.performSegueWithIdentifier("configurar", sender: nil)
            
        }else if(indexPath.row == 6){
            closeSesion()
            
        }
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    //MARK: Functions
    
    func checkData()->Bool{
        return Operacion.getOperaciones() != nil ? true : false
    }
    
    func loadData(){
        if ( checkData() ){
            
            self.performSegueWithIdentifier("nuevoEvento", sender: nil)
            
        }else{
            if Reachability.isConnectedToNetwork(){
                ModelHelper.getRegistros(self)
                self.performSegueWithIdentifier("nuevoEvento", sender: nil)
            }else{
                AlertHelper.notificationAlert("Actualizar Datos", message: "Debes Actualizar los Datos antes de continuar", viewController: self)
            }
            
        }
    }
    
    func closeSesion(){
        ModelHelper.deleteRecords()
        ModelHelper.deleteListado()
        ModelHelper.deleteUsuario()
        let ap =  UIApplication.sharedApplication().delegate as! AppDelegate
        ap.showLogin()
        
    }
    
    
    func imageSlide() {
        slideshow.backgroundColor = UIColor.whiteColor()
        slideshow.slideshowInterval = 5.0
        slideshow.pageControlPosition = PageControlPosition.UnderScrollView
        
        slideshow.setImageInputs([ImageSource(imageString: "banner_1")!, ImageSource(imageString: "banner_2")!, ImageSource(imageString: "banner_3")!, ImageSource(imageString: "banner_4")!, ImageSource(imageString: "banner_5")!])
    }
    
    
   
}
