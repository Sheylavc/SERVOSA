//
//  NewEventViewController.swift
//  SERVOSA
//
//  Created by ucweb on 26/06/16.
//  Copyright © 2016 ucweb. All rights reserved.
//

import UIKit

class NewEventViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate {
    

    //MARK: Declare Var
    var pickerOperacion: UIPickerView!
    var pickerRuta: UIPickerView!
    var pickerTramo: UIPickerView!
    var pickerPlaca: UIPickerView!
    var pickerEvento: UIPickerView!
    var pickerCategoria: UIPickerView!
    var pickerTipo: UIPickerView!
    
    let greenColor = UIColor(red: 138, green: 215, blue: 24)
    let blueColor = UIColor(red: 15, green: 55, blue: 107)
    let grayColor = UIColor(red: 224, green: 224, blue: 224)
    
    private var registrosOperacion: [Operacion]!
    private var registrosRuta: [Ruta]!
    private var registrosTramo: [Tramo]!
    private var registrosPlaca: [Placa]!
    
    private var registrosEvento: [Evento]!
    private var registrosCategoria: [Categoria]!
    private var registrosTipo: [Tipo]!
    
    var idOperacion: NSNumber?
    var idRuta: NSNumber?
    var idTramo: NSNumber?
    var idPlaca: NSNumber?
    var idCategoria: NSNumber?
    var idEvento: NSNumber?
    var idTipo: NSNumber?
    
    
    //MARK: Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        logoView.backgroundColor = blueColor
        
        displayPicker()
        
        registrosOperacion = Operacion.getOperaciones()
        registrosEvento = Evento.getEventos()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK: IBOutlets
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var txtOperacion: UITextField!
    @IBOutlet weak var txtRuta: UITextField!
    @IBOutlet weak var txtTramo: UITextField!
    @IBOutlet weak var txtPlaca: UITextField!
    @IBOutlet weak var txtEventoRiesgo: UITextField!
    @IBOutlet weak var txtCategoria: UITextField!
    @IBOutlet weak var txtTipo: UITextField!
    @IBOutlet weak var txtDescripcion: UITextView!
    @IBOutlet weak var scrollview: UIScrollView!
    
    //MARK: IBActions
    @IBAction func cancelNewEvent(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func saveNewEvent(sender: AnyObject) {
        
        let currentDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.stringFromDate(currentDate)
        
        if validarDatosIngresados(){
            if Reachability.isConnectedToNetwork(){
                ModelHelper.saveEventoRiesgo(self, id_operacion: idOperacion!, id_ruta: idRuta!, id_tramo: idTramo!, id_placa: idPlaca!, id_evento: idEvento!, id_categoria: idCategoria!, id_tipo: idTipo!, fecha: date, descripcion: txtDescripcion.text!)
                
                Listado.createListado(self, id_operacion: idOperacion!, nombre_operacion: txtOperacion.text!, id_ruta: idRuta!, nombre_ruta: txtRuta.text!, id_tramo: idTramo!, nombre_tramo: txtTramo.text!, id_placa: idPlaca!, placa: txtPlaca.text!, id_evento: idEvento!, nombre_evento: txtEventoRiesgo.text!, id_categoria: idCategoria!, nombre_categoria: txtCategoria.text!, id_tipo: idTipo, nombre_tipo: txtTipo.text!, fecha: date, descripcion: txtDescripcion.text!, estado: "1")
            }else{
                Listado.createListado(self, id_operacion: idOperacion!, nombre_operacion: txtOperacion.text!, id_ruta: idRuta!, nombre_ruta: txtRuta.text!, id_tramo: idTramo!, nombre_tramo: txtTramo.text!, id_placa: idPlaca!, placa: txtPlaca.text!, id_evento: idEvento!, nombre_evento: txtEventoRiesgo.text!, id_categoria: idCategoria!, nombre_categoria: txtCategoria.text!, id_tipo: idTipo, nombre_tipo: txtTipo.text!, fecha: date, descripcion: txtDescripcion.text!,estado: "0")
            }
        }else{
            AlertHelper.notificationAlert("Evento de Riesgo", message: "Seleccione todos los campos correctamente antes de enviar su evento", viewController: self)
        }
        
    }
    
    func validarDatosIngresados()-> Bool{
        if idOperacion != nil && idRuta != nil && idTramo != nil && idEvento != nil && idCategoria != nil && idPlaca != nil && txtDescripcion.text.characters.count > 0{
            return true
        }else{
            return false
        }
    }

    //MARK: Displaying pickers
    func displayPicker(){
        pickerOperacion = UIPickerView()
        pickerOperacion.delegate = self
        
        pickerRuta = UIPickerView()
        pickerRuta.delegate = self
        
        pickerTramo = UIPickerView()
        pickerTramo.delegate = self
        
        pickerEvento = UIPickerView()
        pickerEvento.delegate = self
        
        pickerCategoria = UIPickerView()
        pickerCategoria.delegate = self
        
        pickerTipo = UIPickerView()
        pickerTipo.delegate = self
        
        pickerPlaca = UIPickerView()
        pickerPlaca.delegate = self
        
        txtOperacion.inputView = pickerOperacion
        txtOperacion.inputAccessoryView = toolBarOperacionPicker()
        
        txtEventoRiesgo.inputView = pickerEvento
        txtEventoRiesgo.inputAccessoryView = toolBarEventoPicker()
        
        txtRuta.userInteractionEnabled = false
        txtTramo.userInteractionEnabled = false
        txtCategoria.userInteractionEnabled = false
        txtTipo.userInteractionEnabled = false
        txtPlaca.userInteractionEnabled = false
        
        txtDescripcion.delegate = self
    }
    
    //MARK: UITextViewDelegate Functions
    func textViewDidEndEditing(textView: UITextView) {
        scrollview.setContentOffset(CGPointMake(0, 0), animated: true)
        txtDescripcion.resignFirstResponder()
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        scrollview.setContentOffset(CGPointMake(0, 200), animated: true)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            txtDescripcion.resignFirstResponder()
            return false
        }
        return true
    }
    
        
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    //MARK: PickerView Methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerOperacion {
            return registrosOperacion?.count == nil ? 0 : registrosOperacion.count
            
        }else if pickerView == pickerRuta {
            return registrosRuta?.count == nil ? 0 : registrosRuta.count
            
        }else if pickerView == pickerTramo {
            return registrosTramo?.count == nil ? 0 : registrosTramo.count
 
        }else if pickerView == pickerPlaca {
            return registrosPlaca?.count == nil ? 0 : registrosPlaca.count

        }else if pickerView == pickerEvento {
            return registrosEvento?.count == nil ? 0 : registrosEvento.count

        }else if pickerView == pickerCategoria {
            return registrosCategoria?.count == nil ? 0 : registrosCategoria.count
            
        }else if pickerView == pickerTipo {
            return registrosTipo?.count == nil ? 0 : registrosTipo.count

        }
        return 0
        
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerOperacion {
            return registrosOperacion![row].nombre_operacion
        } else if pickerView == pickerRuta {
            return registrosRuta![row].nombre_ruta != nil ? registrosRuta![row].nombre_ruta : ""
        }else if pickerView == pickerTramo{
            return registrosTramo![row].nombre_tramo != nil ? registrosTramo![row].nombre_tramo : ""
        }else if pickerView == pickerPlaca{
            return registrosPlaca![row].placa != nil ? registrosPlaca![row].placa : ""
        }else if pickerView == pickerEvento{
            return registrosEvento![row].nombre_evento != nil ? registrosEvento![row].nombre_evento : ""
        }else if pickerView == pickerCategoria{
            return registrosCategoria![row].nombre_categoria != nil ? registrosCategoria![row].nombre_categoria : ""
        }else if pickerView == pickerTipo{
            return registrosTipo![row].nombre_tipo != nil ? registrosTipo![row].nombre_tipo : ""
        }
        
        return nil

    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // If the active PickerView is the operacionPicker do this ...
        if pickerView == pickerOperacion {
            // Put name in label
            txtOperacion.text = registrosOperacion![row].nombre_operacion
            idOperacion = registrosOperacion![row].id_operacion
            
            // Load ruta and placa data
            registrosRuta = Ruta.getRutasByOperacion(registrosOperacion![row].id_operacion!)!
            registrosPlaca = Placa.getPlacasByOperacion(registrosOperacion![row].id_operacion!)!
            
            // VERY IMPORTANT - Reload all of the PickerView Attributes into the typePicker PickerView
            pickerRuta.reloadAllComponents()
            pickerPlaca.reloadAllComponents()
            
            // Reset to first Row and clear the Label Field
            pickerRuta.selectRow(0, inComponent: 0, animated: true)
            pickerPlaca.selectRow(0, inComponent: 0, animated: true)
            
            // Clear previous name
            txtRuta.text = ""
            txtPlaca.text = ""
            
            txtRuta.userInteractionEnabled = true
            txtRuta.inputView = pickerRuta
            txtRuta.inputAccessoryView = toolBarRutaPicker()
            
            txtPlaca.userInteractionEnabled = true
            txtPlaca.inputView = pickerPlaca
            txtPlaca.inputAccessoryView = toolBarPlacaPicker()

            
        } else if pickerView == pickerRuta { // Determine which Array is to be used to fill the rutaPicker
            txtRuta.text = registrosRuta![row].nombre_ruta
            idRuta = registrosRuta![row].id_ruta
            registrosTramo = Tramo.getTramoByRuta(registrosRuta![row].id_ruta!)!
            pickerTramo.reloadAllComponents()
            pickerTramo.selectRow(0, inComponent: 0, animated: true)
            txtTramo.text = ""
            
            txtTramo.userInteractionEnabled = true
            txtTramo.inputView = pickerTramo
            txtTramo.inputAccessoryView = toolBarTramoPicker()
            
        } else if pickerView == pickerTramo {
            txtTramo.text = registrosTramo![row].nombre_tramo
            idTramo = registrosTramo![row].id_tramo
            
        } else if pickerView == pickerPlaca {
            txtPlaca.text = registrosPlaca![row].placa
            idPlaca = registrosPlaca![row].id_placa
            
        } else if pickerView == pickerEvento {
            txtEventoRiesgo.text = registrosEvento![row].nombre_evento
            idEvento = registrosEvento![row].id_evento
            registrosCategoria = Categoria.getCategoriaByEvento(registrosEvento![row].id_evento!)!
            pickerCategoria.reloadAllComponents()
            pickerCategoria.selectRow(0, inComponent: 0, animated: true)
            txtCategoria.text = ""
            
            txtCategoria.userInteractionEnabled = true
            txtCategoria.inputView = pickerCategoria
            txtCategoria.inputAccessoryView = toolBarCategoriaPicker()
            
        } else if pickerView == pickerCategoria {
            txtCategoria.text = registrosCategoria![row].nombre_categoria
            idCategoria = registrosCategoria![row].id_categoria
            registrosTipo = Tipo.getTipoByCategoria(registrosCategoria![row].id_categoria!)!
            pickerTipo.reloadAllComponents()
            pickerTipo.selectRow(0, inComponent: 0, animated: true)
            txtTipo.text = ""
            
            txtTipo.userInteractionEnabled = true
            txtTipo.inputView = pickerTipo
            txtTipo.inputAccessoryView = toolBarTipoPicker()
            
        } else if pickerView == pickerTipo {
            txtTipo.text = registrosTipo![row].nombre_tipo
            idTipo = registrosTipo![row].id_tipo
        }

    }
    
    
    
    
    
    
    //MARK: Styles Picker ToolBar
    func centerLabel()->UIBarButtonItem{
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        label.font = UIFont(name: "Helvetica", size: 12)
        label.backgroundColor = UIColor.clearColor()
        label.textColor = UIColor.whiteColor()
        label.text = "Seleccione"
        label.textAlignment = NSTextAlignment.Center
        
        return UIBarButtonItem(customView: label)
    }
    
    func newToolBar()-> UIToolbar{
        let toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.BlackTranslucent
        toolBar.tintColor = UIColor.whiteColor()
        toolBar.backgroundColor = UIColor.grayColor()
        return toolBar
    }
    
    func butonItem()->UIBarButtonItem{
        return UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
    }
    
    //MARK: Toolbars
    func toolBarOperacionPicker()->UIToolbar{
        
        let toolBar = newToolBar()
        let defaultButton = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(NewEventViewController.tappedToolBarBtnOperacion))
        let doneButton = UIBarButtonItem(title:"Hecho", style: UIBarButtonItemStyle.Done, target: self, action: #selector(NewEventViewController.donePressedOperacion))
        toolBar.setItems([defaultButton,butonItem(),centerLabel(),butonItem(),doneButton], animated: true)
        return toolBar
    }
    func toolBarRutaPicker()->UIToolbar{
        
        let toolBar = newToolBar()
        let defaultButton = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(NewEventViewController.tappedToolBarBtnRuta))
        let doneButton = UIBarButtonItem(title:"Hecho", style: UIBarButtonItemStyle.Done, target: self, action: #selector(NewEventViewController.donePressedRuta))
        toolBar.setItems([defaultButton,butonItem(),centerLabel(),butonItem(),doneButton], animated: true)
        return toolBar
    }
    func toolBarTramoPicker()->UIToolbar{
        
        let toolBar = newToolBar()
        let defaultButton = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(NewEventViewController.tappedToolBarBtnTramo))
        let doneButton = UIBarButtonItem(title:"Hecho", style: UIBarButtonItemStyle.Done, target: self, action: #selector(NewEventViewController.donePressedTramo))
        toolBar.setItems([defaultButton,butonItem(),centerLabel(),butonItem(),doneButton], animated: true)
        return toolBar
    }
    func toolBarEventoPicker()->UIToolbar{
        
        let toolBar = newToolBar()
        let defaultButton = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(NewEventViewController.tappedToolBarBtnEvento))
        let doneButton = UIBarButtonItem(title:"Hecho", style: UIBarButtonItemStyle.Done, target: self, action: #selector(NewEventViewController.donePressedEvento))
        toolBar.setItems([defaultButton,butonItem(),centerLabel(),butonItem(),doneButton], animated: true)
        return toolBar
    }
    func toolBarCategoriaPicker()->UIToolbar{
        
        let toolBar = newToolBar()
        let defaultButton = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(NewEventViewController.tappedToolBarBtnCategoria))
        let doneButton = UIBarButtonItem(title:"Hecho", style: UIBarButtonItemStyle.Done, target: self, action: #selector(NewEventViewController.donePressedCategoria))
        toolBar.setItems([defaultButton,butonItem(),centerLabel(),butonItem(),doneButton], animated: true)
        return toolBar
    }
    func toolBarTipoPicker()->UIToolbar{
        
        let toolBar = newToolBar()
        let defaultButton = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(NewEventViewController.tappedToolBarBtnTipo))
        let doneButton = UIBarButtonItem(title:"Hecho", style: UIBarButtonItemStyle.Done, target: self, action: #selector(NewEventViewController.donePressedTipo))
        toolBar.setItems([defaultButton,butonItem(),centerLabel(),butonItem(),doneButton], animated: true)
        return toolBar
    }
    func toolBarPlacaPicker()->UIToolbar{
        
        let toolBar = newToolBar()
        let defaultButton = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(NewEventViewController.tappedToolBarBtnPlaca))
        let doneButton = UIBarButtonItem(title:"Hecho", style: UIBarButtonItemStyle.Done, target: self, action: #selector(NewEventViewController.donePressedPlaca))
        toolBar.setItems([defaultButton,butonItem(),centerLabel(),butonItem(),doneButton], animated: true)
        return toolBar
    }
    
    //MARK: Toolbar Functions
    func donePressedOperacion(sender: UIBarButtonItem) {
        txtOperacion.resignFirstResponder()
    }
    
    func tappedToolBarBtnOperacion(sender: UIBarButtonItem) {
        txtOperacion.resignFirstResponder()
        
    }
    func donePressedRuta(sender: UIBarButtonItem) {
        txtRuta.resignFirstResponder()
    }
    
    func tappedToolBarBtnRuta(sender: UIBarButtonItem) {
        txtRuta.resignFirstResponder()
    }
    func donePressedTramo(sender: UIBarButtonItem) {
        txtTramo.resignFirstResponder()
    }
    
    func tappedToolBarBtnTramo(sender: UIBarButtonItem) {
        txtTramo.resignFirstResponder()
    }
    func donePressedEvento(sender: UIBarButtonItem) {
        txtEventoRiesgo.resignFirstResponder()
    }
    
    func tappedToolBarBtnEvento(sender: UIBarButtonItem) {
        txtEventoRiesgo.resignFirstResponder()
    }
    func donePressedCategoria(sender: UIBarButtonItem) {
        txtCategoria.resignFirstResponder()
    }
    
    func tappedToolBarBtnCategoria(sender: UIBarButtonItem) {
        txtCategoria.resignFirstResponder()
    }
    func donePressedTipo(sender: UIBarButtonItem) {
        txtTipo.resignFirstResponder()
    }
    
    func tappedToolBarBtnTipo(sender: UIBarButtonItem) {
        txtTipo.resignFirstResponder()
    }
    func donePressedPlaca(sender: UIBarButtonItem) {
        txtPlaca.resignFirstResponder()
    }
    
    func tappedToolBarBtnPlaca(sender: UIBarButtonItem) {
        txtPlaca.resignFirstResponder()
    }

    
}
