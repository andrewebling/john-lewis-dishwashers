//
//  JSONIntegrationTest.swift
//  Dishwashers
//
//  Created by Andrew Ebling on 06/09/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import XCTest

class JSONIntegrationTest: XCTestCase {
    
    let kFixtureExtension = "json"
    
    func fixtureDataForResourceName(filename: String) -> NSData {
        
        let bundle = Bundle(for: type(of: self))
        
        guard let fixturePath = bundle.path(forResource: filename, ofType: kFixtureExtension) else {
            fatalError("Failed to find fixture named \(filename).\(kFixtureExtension)")
        }
        guard let fixtureData = NSData(contentsOfFile: fixturePath) ,
            fixtureData.length > 0 else {
                fatalError("Failed to load fixture data from \(filename).\(kFixtureExtension)")
        }
        return fixtureData
    }
}
