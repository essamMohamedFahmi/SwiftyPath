//
//  Created by Essam Mohamed Fahmi.
//

import UIKit

public protocol PickTableViewCellDelegate: class
{
    func locationButtonDidTap(_ sender: PickTableViewCell, at index: IndexPath)
}

@objc public protocol UserPathViewDelegate: class
{
    func heightChanged(to height: CGFloat)

    @objc optional func sourcePointDidSet(_ source: PickPoint)
    @objc optional func destinationPointDidSet(_ destination: PickPoint)
    @objc optional func pickPointsDidSet(_ pickPoints: [PickPoint])
    @objc optional func selectLocationTapped()
}
