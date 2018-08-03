//
//  FeatureCell.swift
//  Mobile Catalogue
//
//  Created by Praveen Ojha on 3/8/18.
//  Copyright © 2018 Praveen Ojha. All rights reserved.
//

import UIKit

class FeatureCell: UITableViewCell {

    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtTechnology: UILabel!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var detailText: UILabel!
    @IBOutlet weak var arrowAccordion: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
