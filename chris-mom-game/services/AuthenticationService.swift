//
//  AuthenticationService.swift
//  ChrisMom-Chris Child
//
//  Created by Kesavan Panchabakesan on 24/12/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthenticationService :  ObservableObject {
    
    @Published var isLoggedIn = false
    @Published var loginErrorMsg = ""
    @Published var registerErrorMsg = ""
    
    var userDetailService = UserDetailService()
    
    func login (email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
              
                  if let errorValue = error {
                      print(errorValue.localizedDescription)
                      
                      self.loginErrorMsg = "Either the user mail id and/or password is incorrect."
                  } else {
                      self.isLoggedIn = true
                     
                  }
               }
    }
    
    func register (email: String, password: String, username: String){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            DispatchQueue.main.async {
                if let errorValue = error {
                    print(errorValue.localizedDescription)
                    if(error!.localizedDescription.contains("email address is already in use")){
                        self.registerErrorMsg = "This email id is already exist."
                    }else{
                        self.registerErrorMsg = "Error While creating an account."
                    }
                    
                } else {
                    self.userDetailService.sendUserDetailsInfo(userName: username, userEmailId: email)
                    self.isLoggedIn = true
                }
            }
            
        }
    }
    
    func logOut(){
        do {
          try Auth.auth().signOut()
          self.isLoggedIn = false
          UserDefaults.standard.removeObject(forKey: "userName")
            UserDefaults.standard.removeObject(forKey: "currentUserDocumentId")
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
}

