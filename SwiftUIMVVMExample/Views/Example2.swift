//
//  Example2.swift
//  SwiftUIMVVMExample
//
//  Created by Chee Ket Yung on 06/02/2021.
//

import SwiftUI

struct Example2 : View {
    
    @ObservedObject var employeeViewModel = EmployeeViewModel()
    
    var body: some View {
        
        List (employeeViewModel.allEmployees, id:\.id) {
            employee in
            
            EmployeeRowView(employee: employee)
        }
        .onAppear{
            
            employeeViewModel.loadEmployees()
        }
        .navigationTitle("Example 2")
        .navigationBarTitleDisplayMode(.inline)
     
    }
    
}
