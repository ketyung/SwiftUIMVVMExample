//
//  EmployeeRowView.swift
//  SwiftUIMVVMExample
//
//  Created by Chee Ket Yung on 06/02/2021.
//

import SwiftUI

struct EmployeeRowView : View {
    
    private var employee : EmployeeViewModel
    
    init(employee : EmployeeViewModel){
        
        self.employee = employee
    }
    
    var body: some View {

        VStack(alignment: .leading, spacing: 10) {
        
            Text(employee.name)
            .font(.headline)
            
            Text("Date Joined : \(employee.dateJoined), Years served : \(employee.numberOfYearsServed)")
            .font(.caption)
            
        }
        .frame(height: 50)
    }
}
