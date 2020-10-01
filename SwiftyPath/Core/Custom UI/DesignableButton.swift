import UIKit

@IBDesignable class DesignableButton: UIButton
{
    // MARK: - Properties
    
    @IBInspectable var topCorner: Bool = false
        {
        didSet
        {
            if topCorner && bottomCorner
            {
                layer.maskedCorners = [.layerMinXMinYCorner,
                                       .layerMaxXMinYCorner,
                                       .layerMaxXMaxYCorner,
                                       .layerMinXMaxYCorner]
            }
            else if topCorner
            {
                layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }
        }
    }
    
    @IBInspectable var bottomCorner: Bool = false
        {
        didSet
        {
            if topCorner && bottomCorner
            {
                layer.maskedCorners = [.layerMinXMinYCorner,
                                       .layerMaxXMinYCorner,
                                       .layerMaxXMaxYCorner,
                                       .layerMinXMaxYCorner]
            }
            else if bottomCorner
            {
                layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0
    {
        didSet
        {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.darkGray
    {
        didSet
        {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowOffsetWidth: CGFloat = 0.0
    {
        didSet
        {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowOffsetHeight: CGFloat = 0.0
    {
        didSet
        {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.0
    {
        didSet
        {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0.0
    {
        didSet
        {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable var borderColor: UIColor = .black {
        didSet {
            setNeedsLayout()
        }
    }
    
    // MARK: - Override
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = cornerRadius > 0
        
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        
        layer.shadowColor = shadowColor.cgColor
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}
