//
//  ExportarPyramidViewController.swift
//  SERVOSA
//
//  Created by ucweb on 25/07/16.
//  Copyright © 2016 ucweb. All rights reserved.
//

import UIKit

class ExportarPyramidViewController: UIViewController, UIWebViewDelegate {
    
    let blueColor = UIColor(red: 15, green: 55, blue: 107)
    var filtro: [String : AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoView.backgroundColor = blueColor
        self.webview.delegate = self
        loadVistaWeb()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var webview: UIWebView!
    @IBAction func closeButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func loadVistaWeb(){
        
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
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.uc-web.mobi/SERVOSA/admin/C_Grafico/getDataPiramide")!)
        
        request.HTTPMethod = "POST"
        request.HTTPBody = parameters.dataUsingEncoding(NSUTF8StringEncoding)
        
        webview.loadRequest(request);
        
    }
    
    
    func webViewDidStartLoad(webView: UIWebView) {
        AlertHelper.showLoadingAlert(self)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        AlertHelper.hideLoadingAlert(self)
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print(error?.localizedDescription)
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    

}
