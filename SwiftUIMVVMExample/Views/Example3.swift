//
//  ContentView.swift
//  SwiftUIMVVMExample
//
//  Created by Chee Ket Yung on 04/02/2021.
//

import SwiftUI

struct Example3 : View {
    
    @ObservedObject var employeeViewModel = EmployeeViewModel()
    
    var body: some View {
    
        VStack(alignment: .leading, spacing: 20) {
            
            ScrollViewOfYearRanges(employeeViewModel: employeeViewModel)
            .padding()
            
            List(employeeViewModel.filteredEmployees, id:\.id){
                employee in
        
                EmployeeRowView(employee: employee)
        
            }
            .onAppear{
                
                employeeViewModel.yearsServed()
            }
        }
        .navigationTitle("Example 3")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}


struct Example3_Previews: PreviewProvider {
    static var previews: some View {
        Example3()
    }
}
