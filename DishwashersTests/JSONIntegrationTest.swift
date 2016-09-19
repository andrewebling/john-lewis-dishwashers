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
    
    func fixtureData(forResourceName filename: String) -> Data {
        
        let bundle = Bundle(for: type(of: self))
        
        guard let fixtureURL = bundle.url(forResource: filename, withExtension: kFixtureExtension) else {
            fatalError("Failed to find fixture named \(filename).\(kFixtureExtension)")
        }
        guard let fixtureData = try? Data(contentsOf: fixtureURL) ,
            fixtureData.count > 0 else {
                fatalError("Failed to load fixture data from \(filename).\(kFixtureExtension)")
        }
        return fixtureData
    }
}
