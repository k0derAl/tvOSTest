//
//  TaskMediaCell.swift
//  
//
//  Created by Alexey Nikiforov on 19.06.2020.
//  Copyright © 2020 Alexey Nikiforov. All rights reserved.
//

import UIKit

class MediaCell: UICollectionViewCell {
    
    
    @IBOutlet var photoImageView: UIImageView?
    
    public func configure(path: String) {
        
        photoImageView?.image = UIImage(named: path)
    }
    
    
    override func awakeFromNib() {
        backgroundView = nil
        backgroundColor = UIColor.clear
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        if context.nextFocusedView === self {
            coordinator.addCoordinatedAnimations({
                self.contentView.backgroundColor = UIColor.black
            }, completion: nil)
        }
        else {
            coordinator.addCoordinatedAnimations({
                self.contentView.backgroundColor = UIColor.clear
            }, completion: nil)
        }
        
        
    }
}
