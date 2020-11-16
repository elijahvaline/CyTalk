//
//  CyTalkTests.swift
//  CyTalkTests
//
//  Created by Elijah Valine on 10/16/20.
//

import XCTest
@testable import CyTalk

class CyTalkTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPostCollectionCount(){
        
        ServerUtils.getPostForTests(returnWith: { returns, worked in
            
            if (worked){
                XCTAssertTrue(returns?.count == 4, "Something wrong with the posts")
            }
            
        })
        
    }
    
    func testChatConcat(){
        
        var sampleLog = "eli: hey what's up y'all* ben: yo yo yo what's good ev body* Eli: this new chat function is really fun* ben: ikr Luke did a really good job!*"
        var numMess = ChatSession.numMessages(log: sampleLog)
        
        XCTAssertTrue(numMess == 4, "Whoops, looks like the logic doesnt work correctly")
        
    }
    
    


}
