//
//  Path.swift
//
//  Created by Essam Mohamed Fahmi on 9/24/20.
//

import Foundation

public class Path: NSObject
{
    // MARK: Properties
    
    public var from: PickPoint
    public var to: PickPoint
    public var picks: [PickPoint]

    // MARK: Init
    
    public init(source: PickPoint, destination: PickPoint, picks: [PickPoint])
    {
        self.from = source
        self.to = destination
        self.picks = picks
    }
}
