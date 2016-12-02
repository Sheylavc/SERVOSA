//
//  Categoria.swift
//  SERVOSA
//
//  Created by ucweb on 14/07/16.
//  Copyright © 2016 ucweb. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Categoria: NSManagedObject {

    class func createCategoria(json: AnyObject)->Categoria{
        
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let newCategoria = NSEntityDescription.insertNewObjectForEntityForName("Categoria", inManagedObjectContext: ap.managedObjectContext) as! Categoria
        newCategoria.id_categoria = NSNumber(integer: Int((json["id_categoria"] as! String))!)
        newCategoria.id_evento = NSNumber(integer: Int((json["id_evento"] as! String))!)
        newCategoria.codigo_categoria = json["codigo_categoria"] as? String
        newCategoria.nombre_categoria = json["nombre_categoria"] as? String
        
        ap.saveContext()
        return newCategoria
    }
    
    class func getCategorias()->[Categoria]?{
        let resquest = NSFetchRequest(entityName: "Categoria")
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        do{
            let categoria = try ap.managedObjectContext.executeFetchRequest(resquest) as! [Categoria]
            if let _ = categoria.first{
                return categoria
            }else{
                return nil
            }
            
        }catch {
            return nil
        }
        
    }
    
    class func getCategoriaByEvento(id_evento: NSNumber)->[Categoria]?{
        let resquest = NSFetchRequest(entityName: "Categoria")
        let ap = UIApplication.sharedApplication().delegate as! AppDelegate
        let categoriaSet = NSMutableSet()
        do{
            let categorias = try ap.managedObjectContext.executeFetchRequest(resquest) as! [Categoria]
            for categoria in categorias {
                if(categoria.id_evento == id_evento){
                    categoriaSet.addObject(categoria)
                }
            }
            
        }catch {
            return nil
        }
        return categoriaSet.allObjects as? [Categoria]
    }
    
    class func addTipo(json: AnyObject)->[Tipo]{
        let tipos = json as! [AnyObject]
        let tipoSet = NSMutableSet()
        for tipo in tipos{
            tipoSet.addObject(Tipo.createTipo(tipo))
        }
        return tipoSet.allObjects as! [Tipo]
    }

}
