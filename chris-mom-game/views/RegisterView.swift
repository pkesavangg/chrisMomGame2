//
//  RegisterView.swift
//  ChrisMom-Chris Child
//
//  Created by Kesavan Panchabakesan on 24/12/22.
//



import SwiftUI
import FirebaseAuth



struct RegisterView: View {
    
    
    @ObservedObject var authentication = AuthenticationService()
    @EnvironmentObject var userDetailService : UserDetailService
    
    let validators = Validators()
    @FocusState private var focusField : FocusText?
    @State var usernameFieldValue: String = ""
    @State var emailFieldValue : String = ""
    @State var passwordFieldValue : String = ""
    @State var confirmPasswordFieldValue : String = ""
    @State var isPasswordFieldTouched : Bool = false
    @State var isConfirmPasswordFieldTouched : Bool = false
    @State var emailFieldNotFocused = false
    @State var usernameFieldNotFocused = false
    @State var isEmailFieldTouched : Bool = false
    @State var isUsernameFieldTouched: Bool = false
    @State var passwordErrorMsg = ""
    @State private var showingAlert = false

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
    
    var body: some View {
        
        NavigationView {
            
            VStack{
                ZStack{
                    Text("Register").foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("Color").ignoresSafeArea(edges: .top))
                        .frame(maxWidth: .infinity)
                   
                }
                    
                
                Form{
                    VStack(alignment: .leading, spacing: 20)  {
                        
                        VStack(alignment: .leading){
                            Text("User name").font(.callout)
                            TextField("ex: John Cena" ,text: $usernameFieldValue,onEditingChanged: { edit in
                                if edit == false {
                                    self.usernameFieldNotFocused = true
                                }
                            } ).accentColor(.blue)
                            .focused($focusField , equals: .usernameField)
                            .submitLabel(.next)
                            .onSubmit() {
                                focusField = .emailField
                            }.onTapGesture {
                                self.isUsernameFieldTouched  = true
                            }
                            Divider().padding(.trailing, 20)
                            
                            Text( self.usernameErrorMessage ).font(.caption).foregroundColor(.red)
                        }
                        
                        VStack(alignment: .leading){
                            Text("Email").font(.callout)
                            TextField("xyz@gmail.com" ,text: $emailFieldValue,onEditingChanged: { edit in
                                if edit == false {
                                    self.emailFieldNotFocused = true
                                }
                            } ).autocapitalization(.none).accentColor(.blue)
                            .focused($focusField , equals: .emailField)
                            .submitLabel(.next)
                            .onSubmit() {
                                focusField = .passwordField
                            }.onTapGesture {
                                self.isEmailFieldTouched  = true
                            }
                            Divider().padding(.trailing, 20)
                            
                            Text( self.emailErrorMessage ).font(.caption).foregroundColor(.red)
                        }
                        
                        VStack(alignment: .leading){
                            
                            VStack(alignment: .leading){
                                Text("Password").font(.callout)
                                SecureField("7845*wdK" , text: $passwordFieldValue).accentColor(.blue)
                                .focused($focusField , equals: .passwordField)
                                .submitLabel(.next)
                                .onSubmit() {
                                    focusField = .confirmPasswordField
                                }
                                .onTapGesture {
                                    self.isPasswordFieldTouched = true
                                }
                                Divider().padding(.trailing, 20)
                                
                                Text( self.passwordErrorMessage ).font(.caption).foregroundColor(.red)
                            }
                            
                        }
                        
                        VStack(alignment: .leading){
                            
                            VStack(alignment: .leading){
                                Text("Confirm Password").font(.callout)
                                SecureField("7845*wdK" , text: $confirmPasswordFieldValue).accentColor(.blue)
                                .focused($focusField , equals: .confirmPasswordField)
                                .submitLabel(.done)
                                .onSubmit() {
                                    register()
                                }
                                .onTapGesture {
                                    self.isConfirmPasswordFieldTouched = true
                                }
                                Divider().padding(.trailing, 20)
                                
                                Text( self.confirmPasswordErrorMsg ).font(.caption).foregroundColor(.red)
                            }
                        }
                      
                        
                        HStack{
                            Spacer()
                            Button(action: register) {
                                Text("Register") + Text(Image(systemName: "arrow.right"))
                            }.disabled(!isRegisterFormValid).accentColor(.blue)
                            Spacer()
                        }
                        
                        Spacer()
                    }.padding(.leading, 20 ).padding(.top, 30)
                }.alert(authentication.registerErrorMsg, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) {
                        authentication.registerErrorMsg = ""
                    }
                }
                
                
                if(authentication.registerErrorMsg != "") {
                    Text("").foregroundColor(.red).onAppear{
                        showAlert()
                    }
                }
                Spacer()
                NavigationLink("", destination: MainView(isDashboardView: $authentication.isLoggedIn ), isActive: $authentication.isLoggedIn)
                
                
            }.gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)}).navigationBarBackButtonHidden(true)
            
        }.accentColor(.white)
    }
    
    private func showAlert() {
        self.showingAlert = true
     }
    
    private func register() {
        if(isRegisterFormValid){
            authentication.register(email: self.emailFieldValue, password: self.passwordFieldValue, username: self.usernameFieldValue)
//            if(authentication.isLoggedIn){
//                userDetailService.sendUserDetailsInfo(userName: self.usernameFieldValue, userEmailId: self.emailFieldValue )
//            }
           
        }
        
    }

   
    
    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

