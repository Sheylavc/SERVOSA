//
//  ItemCell.swift
//  SERVOSA
//
//  Created by ucweb on 22/06/16.
//  Copyright © 2016 ucweb. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    @IBOutlet weak var imagenView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
