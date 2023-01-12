//
//  LoginViewModal.swift
//  chris-mom-game
//
//  Created by Kesavan Panchabakesan on 12/01/23.
//

import Foundation

class AddCoffeeOrderViewModel: ObservableObject {
    
    var name: String = ""
    @Published var size: String = "Medium"
    @Published var coffeeName: String = ""
    
    private var authentication: AuthenticationService
    
   
    
    init() {
        self.authentication = AuthenticationService()
    }
    
 
    
    func login(email: String, password: String) {
        
        
//        self.authentication.login(email: email, password: password) { _ in
//
//        }
       
    }
    func register(email: String, password: String, username: String) {
        
        
//        self.authentication.register(email: email, password: password, username: username) { _ in
//            
//        }
       
    }
 
    
}
