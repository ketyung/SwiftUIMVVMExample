//
//  TestView.swift
//  SwiftUIMVVMExample
//
//  Created by Chee Ket Yung on 04/02/2021.
//

import SwiftUI

struct Example1 : View {
    
    let employees = Bundle.main.decodeJson([Employee].self, fileName: "Employees.json",
                                           dateDecodingStrategy:
                                           DateFormatter().jsonDateDecodingStrategy(dateFormat: "yyyy-MM-dd"))
  
    var body: some View {
        
        List((0..<employees.count)){
            idx in
            
            Text("\(idx+1). \(employees[idx].name)")
            
        }
        .navigationTitle("Example 1")
        .navigationBarTitleDisplayMode(.inline)
    }
}
