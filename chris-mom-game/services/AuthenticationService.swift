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
    @Published var isLoading = false
    
    static let shared: AuthenticationService = AuthenticationService()
    var userDetailService = UserDetailService()
    
    func login (email: String, password: String  , completion: @escaping (Error?) -> ()){
        self.isLoading = true
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            
            if let errorValue = error {
                print(errorValue.localizedDescription)
                completion(error)
                self.isLoading = false
            } else {
                self.isLoggedIn = true
                DispatchQueue.main.async {
                    if let user = authResult?.user{
                        print("Login Successfully",user )
                        self.isLoading = false
                    }
                }
            }
        }
    }
    
    func register (email: String, password: String, username: String,  completion: @escaping (Error?) -> ()){
        self.isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            DispatchQueue.main.async {
                if let errorValue = error {
                    print(errorValue.localizedDescription)
                    completion(error)
                    self.isLoading = false
                } else {
                    print("Register Successfully" )
                    self.userDetailService.sendUserDetailsInfo(userName: username, userEmailId: email)
                    self.isLoggedIn = true
                    self.isLoading = false
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
            UserDefaults.standard.removeObject(forKey: "currentUserMailId")
            print("Logout Successfully" )
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func forgotPassword(email: String){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
          // ...
        }
    }
    
    func changePassword(password: String){
        Auth.auth().currentUser?.updatePassword(to: password) { (error) in
          // ...
        }
    }
    
}

