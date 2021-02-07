//
//  Menu.swift
//  SwiftUIMVVMExample
//
//  Created by Chee Ket Yung on 05/02/2021.
//

import SwiftUI


enum PushToViewType : String, Decodable {
    case example1
    case example2
    case example3
    case example4
}


struct MenuItem : Decodable , Identifiable {
    
    var id = UUID()
    
    var title : String
    
    var pushToViewType : PushToViewType
    
    private enum CodingKeys : String, CodingKey { case title, pushToViewType }
}



struct Menu : View {
    

    let menus = Bundle.main.decodeJson([MenuItem].self, fileName: "Menus.json")
    
    
    var body: some View {
        
        NavigationView {
   
            List(menus) { menu in
                
                NavigationLink( destination: pushToViewType(menu.pushToViewType)){
                    
                    Text( menu.title )
                    .font(.body)
                }
            }
            .navigationTitle("Menu")
     
        }
       
    }
}


extension Menu {
    
    
    @ViewBuilder
    private func pushToViewType(_ pushToViewType : PushToViewType) -> some View{
        
        
        switch (pushToViewType){
        
            case .example1 :
                Example1()
            case .example2 :
                Example2()
            case .example3 :
                Example3()
            case .example4 :
                Example4()
                
        }
    }
}
