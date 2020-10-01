//
//  ApplicationEx.swift
//
//  Created by Essam Mohamed Fahmi on 9/24/20.
//

import UIKit

extension UIResponder
{
    /**
     * Returns the next responder in the responder chain cast to the given type, or
     * if nil, recurses the chain until the next responder is nil or castable.
     */
    func next<U: UIResponder>(of type: U.Type = U.self) -> U?
    {
        return self.next.flatMap({ $0 as? U ?? $0.next() })
    }
}
