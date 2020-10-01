//
//  Created by Essam Mohamed Fahmi.
//

import UIKit

public class UserPathView: UIView
{
    // MARK: Outlets
    
    @IBOutlet weak var theContentView: UIView!
    
    @IBOutlet weak var pickTableView: UITableView!

    @IBOutlet weak var pickPointOptionsStack: UIStackView!
    @IBOutlet weak var addPickPointButton: UIButton!
    @IBOutlet weak var removePickPointButton: UIButton!
    
    @IBOutlet weak var sourceButton: UIButton!
    @IBOutlet weak var destinationButton: UIButton!

    @IBOutlet weak var pickTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    
    // MARK: Properties
    
    public weak var delegate: UserPathViewDelegate?
    private var initalPathSet = true

    private var source: PickPoint!
    {
        didSet
        {
            sourceButton.setTitle(source.name, for: .normal)
            if initalPathSet { delegate?.sourcePointDidSet?(source) }
        }
    }
    
    private var destination: PickPoint!
    {
        didSet
        {
            destinationButton.setTitle(destination.name, for: .normal)
            if initalPathSet { delegate?.destinationPointDidSet?(destination) }
        }
    }
    
    private var numberOfAllowedPickPoints = 3
    private var currentPickIndex: Int!
    private var pickPoints: [PickPoint] = []
    {
        didSet
        {
            refreshPicksTable()
            guard pickPoints.filter({ $0.lat == nil || $0.lng == nil }).count == 0 else { return }
            if initalPathSet { delegate?.pickPointsDidSet?(pickPoints) }
        }
    }
    
    private var currentSelection: Selection!
    private enum Selection
    {
        case source
        case destination
        case pickPoint
    }
        
    // MARK: View Life Cycle
    
    override public init(frame: CGRect)
    {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Private Methods
    
    private func setup()
    {
        loadXIBFromMemory()
        setupContentView()
        initPickTableView()
        resizeViews()
    }
    
    private func setupContentView()
    {
        theContentView.frame = bounds
        theContentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(theContentView)
    }
    
    private func initPickTableView()
    {
        pickTableView.register(cell: PickTableViewCell.self)

        pickTableView.dataSource = self
        pickTableView.delegate = self
        
        pickTableView.hideEmptyCells()
        
        pickTableView.alwaysBounceVertical = false
        pickTableView.isScrollEnabled = false
    }
    
    private func resizeViews()
    {
        let cellHeight = 50
        let viewStartHeight = 150
        
        let tableViewExpectedHeight = pickPoints.count * cellHeight
        pickTableViewHeight.constant = CGFloat(tableViewExpectedHeight)
        
        let newViewHeight = viewStartHeight + tableViewExpectedHeight
        containerViewHeight.constant = CGFloat(newViewHeight)

        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.checkAddPickPointButtonStatus()
            self?.checkRemovePickPointButtonStatus()
            self?.pickPointOptionsStack.layoutIfNeeded()
            self?.theContentView.layoutIfNeeded()
            self?.delegate?.heightChanged(to: CGFloat(newViewHeight))
        }
    }
    
    private func checkRemovePickPointButtonStatus()
    {
        let removeButtonShouldBeVisible = pickPoints.count > 0
        removePickPointButton.alpha = removeButtonShouldBeVisible ? 1.0 : 0.0
        removePickPointButton.isHidden = !removeButtonShouldBeVisible
    }
    
    private func checkAddPickPointButtonStatus()
    {
        let addButtonShouldBeVisible = pickPoints.count < numberOfAllowedPickPoints
        addPickPointButton.alpha = addButtonShouldBeVisible ? 1.0 : 0.0
        addPickPointButton.isHidden = !addButtonShouldBeVisible
    }
    
    private func removeLastPickPoint()
    {
        pickPoints.removeLast()
    }
    
    private func selectLocation()
    {
        delegate?.selectLocationTapped?()
    }
    
    private func refreshPicksTable()
    {
        DispatchQueue.main.async { [weak self] in
            self?.pickTableView.reloadData()
            self?.resizeViews()
        }
    }
    
    // MARK: Actions

    @IBAction func addPickPointTapped(_ sender: UIButton)
    {
        if pickPoints.count == numberOfAllowedPickPoints { return }
        let pickPoint = PickPoint()
        pickPoints.append(pickPoint)
    }
    
    @IBAction func removePickPointTapped(_ sender: UIButton)
    {
        removeLastPickPoint()
    }
    
    @IBAction func sourcePointAction(_ sender: UIButton)
    {
        currentSelection = .source
        selectLocation()
    }
    
    @IBAction func destinationPointAction(_ sender: UIButton)
    {
        currentSelection = .destination
        selectLocation()
    }
}

// MARK: UITableViewDelegate

extension UserPathView: UITableViewDelegate
{
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: UITableViewDataSource

extension UserPathView: UITableViewDataSource
{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return pickPoints.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeue() as PickTableViewCell
        cell.delegate = self
        cell.configure(pickPoints[indexPath.row], at: indexPath)
        return cell
    }
}

// MARK: PickTableViewCellDelegate

extension UserPathView: PickTableViewCellDelegate
{
    public func locationButtonDidTap(_ sender: PickTableViewCell, at index: IndexPath)
    {
        currentPickIndex = index.row
        currentSelection = .pickPoint
        selectLocation()
    }
}

// MARK: Methods user can interact with

extension UserPathView
{
    func locationSelected(_ location: PickPoint)
    {
        switch currentSelection
        {
        case .source: source = location
        case .destination: destination = location
        case .pickPoint: pickPoints[currentPickIndex] = location
        case .none: break
        }
    }
    
    func setSourceLocation(to sourceLocation: PickPoint)
    {
        source = sourceLocation
    }
    
    func setUserPath(to path: Path)
    {
        initalPathSet = false

        source = path.from
        destination = path.to
        pickPoints = path.picks
        
        initalPathSet = true
    }
}
