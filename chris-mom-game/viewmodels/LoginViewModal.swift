//
//  LoginViewModal.swift
//  chris-mom-game
//
//  Created by Kesavan Panchabakesan on 07/02/23.
//

import Foundation
final class LoginViewModel: ObservableObject {
    
    private var authentication: AuthenticationService
    @Published var showLoader = false
    @Published var loginErrorMsg = ""
    @Published var showAlert = false
    @Published  var emailFieldValue = ""
    @Published  var passwordFieldValue = ""
    @Published var emailFieldNotFocused = false
    @Published var isEmailFieldTouched : Bool = false
    @Published  var presentAlert = false
    @Published var isLoading: Bool = false
    
    
    let validators = Validators()
    var emailErrorMessage : String{
        if( self.emailFieldNotFocused && self.isEmailFieldTouched && self.emailFieldValue.count > 0){
            if(!validators.textFieldValidatorEmail(emailFieldValue)){
                return "Must use a valid email"
            }else{
                return ""
            }
        }
        
        if (self.emailFieldNotFocused && self.emailFieldValue.isEmpty && self.isEmailFieldTouched ) {
            return "Must not left blank"
        }
        return  ""
    }
    
    var isLoginFormValid : Bool{
        if(validators.textFieldValidatorEmail(emailFieldValue) && !passwordFieldValue.isEmpty ){
            return true
        }else{
            return false
        }
    }
    
    init() {
        self.authentication = AuthenticationService.shared
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
           //self.showLoader = true
        }
    }
    
    func login() {
        
        if(isLoginFormValid){
            self.isLoading = true
            self.authentication.login(email: self.emailFieldValue, password: self.passwordFieldValue) { error in
                self.loginErrorMsg = "Either the user mail id and/or password is incorrect."
                self.showAlert = true
               
            }
           
            
           
        }
        
    }
}
