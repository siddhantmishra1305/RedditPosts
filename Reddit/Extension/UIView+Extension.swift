//
//  UIView+Extension.swift
//  Reddit
//
//  Created by Siddhant Mishra on 13/02/22.
//

import Foundation
import UIKit

extension UIView
{
    // This funtion is to inflate a UIView from nib.
    class func fromNib(named: String? = nil) -> Self {
        let name = named ?? "\(Self.self)"
        guard
            let nib = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        else { fatalError("missing expected nib named: \(name)") }
        guard
            
            let view = nib.first as? Self
        else { fatalError("view of type \(Self.self) not found in \(nib)") }
        return view
    }
    
    
    // This function add shadows to a UIView.
    func setShadow(applyShadow : Bool) {
        if applyShadow {
            self.layer.shadowOffset = CGSize.zero
            self.layer.shadowColor = UIColor.darkGray.cgColor
            self.layer.shadowOpacity = 0.5
            self.layer.shadowRadius = 2
            self.layer.masksToBounds = false
            self.clipsToBounds = false
        } else {
            self.layer.shadowRadius = 0
            self.layer.shadowColor = UIColor.clear.cgColor
        }
    }
}
