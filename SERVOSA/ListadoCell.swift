//
//  ListadoCell.swift
//  SERVOSA
//
//  Created by ucweb on 19/07/16.
//  Copyright © 2016 ucweb. All rights reserved.
//

import UIKit

class ListadoCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var operacion: UILabel!
    @IBOutlet weak var ruta: UILabel!
    @IBOutlet weak var tramo: UILabel!
    @IBOutlet weak var evento: UILabel!
    @IBOutlet weak var fecha: UILabel!
    @IBOutlet weak var categoria: UILabel!
    @IBOutlet weak var tipo: UILabel!
    @IBOutlet weak var descripcion: UILabel!
    
}
