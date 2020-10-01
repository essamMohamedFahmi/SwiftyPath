//
//  XIB.swift
//
//  Created by Essam Mohamed Fahmi on 9/24/20.
//

import UIKit

extension UIView
{
    static var nib: UINib
    {
        return UINib(nibName: "\(self)", bundle: Bundle(for: Self.self))
    }
    
    static func instantiateFromNib() -> Self?
    {
        return nib.instantiate() as? Self
    }
    
    func loadXIBFromMemory()
    {
        Bundle(for: Self.self).loadNibNamed("\(Self.self)", owner: self, options:nil)
    }
}

extension UINib
{
    func instantiate() -> Any?
    {
        return instantiate(withOwner: nil, options: nil).first
    }
}
