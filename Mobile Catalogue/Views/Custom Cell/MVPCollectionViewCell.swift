//
//  MVPCollectionViewCell.swift
//  Mobile Catalogue
//
//  Created by Praveen Ojha on 31/7/18.
//  Copyright © 2018 Praveen Ojha. All rights reserved.
//

import UIKit

class MVPCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var lblMVP: UILabel!
    @IBOutlet weak var mvpIconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    func configure(with model: MVPModel){
        self.cellView.backgroundColor = UIColor(hexString: model.bgColor)
        self.lblMVP.textColor = UIColor(hexString: model.fgColor)
        self.mvpIconImage.image = UIImage(named: model.imageName)
        self.lblMVP.text = model.title
//        self.cellView.backgroundColor = UIColor.green
    }
}

import Foundation
import UIKit
extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
