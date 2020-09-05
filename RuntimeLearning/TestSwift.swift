//
//  TestSwift.swift
//  RuntimeLearning
//
//  Created by 贺超 on 2020/4/24.
//  Copyright © 2020 hechao. All rights reserved.
//

import Foundation

struct TestStruct {
    var age = 21
    var married = false
    var height = 17
}

class TestSwift : NSObject {
    @objc class public func testSwiftMethod() {
        var aStruct = TestStruct()
        aStruct.married = true
        print("testSwiftMethod")
    }
}
