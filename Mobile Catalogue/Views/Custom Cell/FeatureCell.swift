//
//  FeatureCell.swift
//  Mobile Catalogue
//
//  Created by Praveen Ojha on 3/8/18.
//  Copyright © 2018 Praveen Ojha. All rights reserved.
//

import UIKit

class FeatureCell: AccordionTableViewCell {

    @IBOutlet weak var headerView: UIView!
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
    
    // MARK: Override
    
    override func setExpanded(_ expanded: Bool, animated: Bool) {
        super.setExpanded(expanded, animated: animated)
        
        if animated {
            let alwaysOptions: UIViewAnimationOptions = [.allowUserInteraction,
                                                         .beginFromCurrentState,
                                                         .transitionCrossDissolve]
            //let expandedOptions: UIViewAnimationOptions = [.transitionFlipFromTop, .curveEaseOut]
            let expandedOptions: UIViewAnimationOptions = [.showHideTransitionViews]
            let collapsedOptions: UIViewAnimationOptions = [.transitionFlipFromBottom, .curveEaseIn]
            let options = expanded ? alwaysOptions.union(expandedOptions) : alwaysOptions.union(collapsedOptions)
            
            UIView.transition(with: detailView, duration: 0.5, options: options, animations: {
                self.toggleCell()
            }, completion: nil)
        } else {
            toggleCell()
        }
    }
    
    // MARK: Helpers
    
    private func toggleCell() {
        detailView.isHidden = !expanded
        arrowAccordion.transform = expanded ? CGAffineTransform(rotationAngle: CGFloat.pi) : .identity
    }
    
}
