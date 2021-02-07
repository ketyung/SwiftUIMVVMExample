//
//  Example3.swift
//  SwiftUIMVVMExample
//
//  Created by Chee Ket Yung on 05/02/2021.
//

import SwiftUI

struct Example4 : View {
    
    @StateObject private var employeeViewModel = EmployeeViewModel()
    
    @State private var selectedDepartment : Department = .engineering
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            VStack(alignment: .leading, spacing: 5) {
           
                Text("Departments :")
                .font(.headline)
               
                scrollViewOfDepartments()
               
            }.padding()
            
            List(employeeViewModel.filteredEmployees, id:\.id){
                employee in
        
                EmployeeRowView(employee: employee)
            }
            .onAppear{
                
                employeeViewModel.inDepartment()
            }
        }
        .navigationTitle("Example 4")
        .navigationBarTitleDisplayMode(.inline)
    }
}


extension Example4 {
    
    @ViewBuilder
    func scrollViewOfDepartments() -> some View {
        
        let departments = Department.allCases
        
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack {
                
                ForEach(departments, id:\.self){ dep in
                    
                    Text("\(dep.rawValue.upperCaseFirst())")
                    .frame(width: 130, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .background( (self.selectedDepartment == dep) ? Color.blue : Color.gray )
                    .cornerRadius(20)
                    .onTapGesture {
                    
                        self.employeeViewModel.inDepartment(department: dep)
                        self.selectedDepartment = dep
                    }
                }
            }
        }
    }
}
