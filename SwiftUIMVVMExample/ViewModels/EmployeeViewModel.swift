//
//  EmployeeViewModel.swift
//  SwiftUIMVVMExample
//
//  Created by Chee Ket Yung on 04/02/2021.
//

import Foundation


class EmployeeViewModel : ObservableObject, Identifiable {
    

    @Published private var allEmployeeViewModels : [EmployeeViewModel] = []
    
    @Published private var filteredEmployeeViewModels : [EmployeeViewModel] = []
    
    private var employee : Employee?
   
    init(employee : Employee? = nil ){
        self.employee = employee
    }
    
    var id = UUID()
    
    var name : String {
        employee?.name ?? "" // defaulted to blank string if nil
    }
    
    var department : Department {
        employee?.department ?? .engineering // defaulted to engineering if nil
    }

    var dateJoined : String {
        
        if let dj = employee?.dateJoined {
            
            return DateFormatter().string(from : dj, dateFormat: "dd/MMM/yy")
        }
        
        return ""
    }
    
    
    var numberOfYearsServed : Int {
        
        if let dj = employee?.dateJoined {
            
            let yearComp = Calendar.current.dateComponents([.year], from: dj, to: Date())
            if let year = yearComp.year{
                
                return year
            }
            
        }
        
        return 0
    }
    
    
    var allEmployees : [EmployeeViewModel] {
        
        self.allEmployeeViewModels.sorted {
            
            $0.name < $1.name
        }
    }
   
    
    var filteredEmployees : [EmployeeViewModel] {
        
        self.filteredEmployeeViewModels.sorted {
            
            $0.numberOfYearsServed < $1.numberOfYearsServed
        }
    }
    
    
}


extension EmployeeViewModel {
    
    
    func loadEmployees (toRemoveAllFirst : Bool = true) {

        let employees = Bundle.main.decodeJson(
            [Employee].self, fileName: "Employees.json",
            dateDecodingStrategy:
            DateFormatter().jsonDateDecodingStrategy(dateFormat: "yyyy-MM-dd"))

        if toRemoveAllFirst {
            self.allEmployeeViewModels.removeAll()
        }
        
        employees.forEach { employee in
            
            self.allEmployeeViewModels.append(EmployeeViewModel(employee: employee))
        }
    
    }
    
    
    
    
    func yearsServed(_ start : Int = 0 , _ end : Int = 5){
      
        if ( allEmployeeViewModels.count == 0 ){
            self.loadEmployees()
        }
        
        self.filteredEmployeeViewModels = self.allEmployeeViewModels.filter{
            
            $0.numberOfYearsServed >= start && $0.numberOfYearsServed <= end
        }
    }
 
   
    
}



extension EmployeeViewModel {
    
    private func loadFromRemoteURL(){
        
        URLSession.shared.decodeJson([Employee].self,
                urlString: "https://raw.githubusercontent.com/ketyung/somejsonfiles/main/EmployeeListWithDepartment.json",
                 completion: { result in
                     switch(result){
                         // switch case on success
                         case .success(let employees) :
                        
                            employees.forEach { employee in
                                
                                // for @Published - must publish in main thread
                                // instead of background thread, hence
                                // DispatchQueue.main.async is used here
                                DispatchQueue.main.async {
                              
                                    self.allEmployeeViewModels.append(EmployeeViewModel(employee: employee))
                                  
                                    self.filteredEmployeeViewModels = self.allEmployeeViewModels.filter{
                                        
                                        $0.department == .engineering // default to engineering department
                                    }
                                }
                            }
                         // case on failure
                         case .failure(let err) :
                            // handle the error
                            print("error :\(err)")
                     }
                 },
                 dateDecodingStrategy:
                 DateFormatter().jsonDateDecodingStrategy(dateFormat: "yyyy-MM-dd")
        )
    }
    
    
    func inDepartment(department : Department = .engineering){
        
        if ( allEmployeeViewModels.count == 0 ){
       
            self.loadFromRemoteURL()
           
        }
        
        self.filteredEmployeeViewModels = self.allEmployeeViewModels.filter{
            
            $0.department == department
        }
    }
}
