//
//  ScrollViewOfYearRanges.swift
//  SwiftUIMVVMExample
//
//  Created by Chee Ket Yung on 06/02/2021.
//

import SwiftUI

struct ScrollViewOfYearRanges : View {
    
    @State private var yearSelectedIndex = 0
   
    var employeeViewModel : EmployeeViewModel
    
    var body : some View {
        
        let yearRanges  = [ (0,5), (6,10), (11,15), (16,20), (21,25) ]
       
        ScrollView (.horizontal, showsIndicators: false ) {
           
            HStack {
           
                ForEach ( (0..<yearRanges.count)){
                    idx in
                    
                    let yr = yearRanges[idx]
            
                    Text("\(yr.0) - \(yr.1)")
                    .frame(width: 80, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .background( (self.yearSelectedIndex == idx) ? Color.green : Color.gray )
                    .cornerRadius(20)
                    .onTapGesture {
                        self.employeeViewModel.yearsServed( yr.0, yr.1 )
                        self.yearSelectedIndex = idx
                    }
                    
                }
                
                    
            }
        }
        .frame(alignment: .leading)
        
    }
}



struct ScrollViewOfYearRanges_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewOfYearRanges(employeeViewModel:  EmployeeViewModel())
    }
}
