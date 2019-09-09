//
//  getNumber.swift
//  errorLab
//
//  Created by Phoenix McKnight on 9/6/19.
//  Copyright © 2019 Phoenix McKnight. All rights reserved.
//

import Foundation
struct GetNumbers {
static func getNumber() -> Int {
    return Int.random(in: 1...2100)
}
}
