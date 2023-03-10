//
//  RegisterViewModal.swift
//  chris-mom-game
//
//  Created by Kesavan Panchabakesan on 07/02/23.
//

import Foundation
final class RegisterViewModel: ObservableObject {
    private var authentication: AuthenticationService

    let validators = Validators()
    @Published var registerErrorMsg = ""
    @Published var showAlert = false
    @Published var usernameFieldValue: String = ""
    @Published var emailFieldValue : String = ""
    @Published var passwordFieldValue : String = ""
    @Published var confirmPasswordFieldValue : String = ""
    @Published var isPasswordFieldTouched : Bool = false
    @Published var isConfirmPasswordFieldTouched : Bool = false
    @Published var emailFieldNotFocused = false
    @Published var usernameFieldNotFocused = false
    @Published var isEmailFieldTouched : Bool = false
    @Published var isUsernameFieldTouched: Bool = false
    @Published var passwordErrorMsg = ""
    
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
    
    var usernameErrorMessage : String{
        if(self.usernameFieldNotFocused && self.usernameFieldValue.isEmpty && self.isUsernameFieldTouched){
            return "Must not left blank"
        }
        return  ""
    }
    
    var passwordErrorMessage : String {
        if(self.isPasswordFieldTouched &&  !self.passwordFieldValue.isEmpty && passwordFieldValue.count < 6){
            return "Password must be 6 characters long"
        }
        if ( self.passwordFieldValue.isEmpty && self.isPasswordFieldTouched ) {
            return "Must not left blank"
        }
        return  ""
    }
    
    var confirmPasswordErrorMsg : String{
        if(self.isConfirmPasswordFieldTouched &&  !self.confirmPasswordFieldValue.isEmpty && confirmPasswordFieldValue != passwordFieldValue){
            return "Both passwords should be same"
        }
        if ( self.confirmPasswordFieldValue.isEmpty && self.isConfirmPasswordFieldTouched ) {
            return "Must not left blank"
        }
        return  ""
    }
    
    var isRegisterFormValid : Bool{
        if( !passwordFieldValue.isEmpty && passwordErrorMessage == "" && !confirmPasswordFieldValue.isEmpty && confirmPasswordErrorMsg == ""
            && !usernameFieldValue.isEmpty && usernameErrorMessage == "" && validators.textFieldValidatorEmail(emailFieldValue)){
            return true
        }
        return false
    }
    
    init() {
        self.authentication = AuthenticationService.shared
    }
    
    
    func register() {
        if(isRegisterFormValid){
            self.authentication.register(email: self.emailFieldValue, password: self.passwordFieldValue, username: self.usernameFieldValue) { error in
                self.showAlert = true
                if(error!.localizedDescription.contains("email address is already in use")){
                    self.registerErrorMsg = "This email id is already exist."
                }else{
                    self.registerErrorMsg = "Error While creating an account."
                }
            }
        }
    }
    
}
