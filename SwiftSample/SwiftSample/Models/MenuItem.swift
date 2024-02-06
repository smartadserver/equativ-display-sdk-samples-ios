//
//  MenuItem.swift
//  SwiftSample
//
//  Created by Loïc GIRON DIT METAZ on 11/10/2023.
//

import Foundation

class MenuItem: NSObject {
    
    let title: String
    let segueIdentifier: String
    
    init(title: String, segueIdentifier: String) {
        self.title = title
        self.segueIdentifier = segueIdentifier
        super.init()
    }
    
}
