//
//  Employee.swift
//  SwiftUIMVVMExample
//
//  Created by Chee Ket Yung on 04/02/2021.
//

import Foundation

enum Department : String, Decodable, CaseIterable {
    
    case engineering
    
    case marketing
    
    case service
}



struct Employee : Decodable {
    
    var name : String

    var dateJoined : Date
    
    // optional
    // key does not necessarily to be in JSON
    var department : Department?

}
