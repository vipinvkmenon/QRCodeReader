//
//  Registry.swift
//  QRCodeReader
//
//  Created by VijayKumar, Vipin on 02/11/19.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import Foundation

class Registry{
    let id: Int64?
    var email: String
    
    init(id: Int64) {
        self.id = id
        email = ""
    }
    init(id: Int64, email: String) {
        self.id = id
        self.email = email
    }
}
