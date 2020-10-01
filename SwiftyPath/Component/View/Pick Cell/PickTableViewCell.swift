//
//  Created by Essam Mohamed Fahmi.
//  Copyright © 2020 Alamat. All rights reserved.
//

import UIKit

public class PickTableViewCell: UITableViewCell
{
    // MARK: Outlets
    
    @IBOutlet weak var locationButton: UIButton!
    
    // MARK: Properities
    
    weak var delegate: PickTableViewCellDelegate?
    private var index: IndexPath!
    
    // MARK: Class Methods
    
    public override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    public override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(_ pickPoint: PickPoint, at index: IndexPath)
    {
        self.index = index
        locationButton.setTitle(pickPoint.name, for: .normal)
    }
    
    // MARK: Actions
    
    @IBAction func locationButtonTapped(_ sender: UIButton)
    {
        delegate?.locationButtonDidTap(self, at: self.index)
    }
}
