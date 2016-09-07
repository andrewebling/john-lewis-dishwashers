//
//  StoryboardTests.swift
//  Dishwashers
//
//  Created by Andrew Ebling on 07/09/2016.
//  Copyright © 2016 Tenero. All rights reserved.
//

import XCTest

class StoryboardTests: XCTestCase {

    var storyboard: UIStoryboard!
    
    override func setUp() {
        super.setUp()
        
        self.storyboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.dynamicType))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testBasicStoryboardConfiguration() {
        guard let navigationController = self.storyboard.instantiateInitialViewController() as? UINavigationController else {
            XCTFail("Did not find a navigation controller as the root view controller in storyboard")
            return
        }
        
        guard let _ = navigationController.topViewController as? ProductGridCollectionViewController else {
            XCTFail("Did not find an instance of ProductGridCollectionViewController as the navigationController's topViewController")
            return
        }
    }
}
