//
//  Place.swift
//  Coins
//
//  Created by Vitaly Berg on 8/13/17.
//  Copyright © 2017 Vitaly Berg. All rights reserved.
//

import Foundation

struct Place {
    let id: Int
    let categoryId: Int?
    let name: String
    let location: (lat: Double, lon: Double)
}
