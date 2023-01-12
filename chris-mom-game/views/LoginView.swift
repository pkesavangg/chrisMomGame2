//
//  LoginView.swift
//  ChrisMom-Chris Child
//
//  Created by Kesavan Panchabakesan on 24/12/22.
//

import SwiftUI

enum FocusText {
    case usernameField, emailField , passwordField, confirmPasswordField
}


struct LoginView: View {
    @ObservedObject var authentication = AuthenticationService()
    let validators = Validators()
    @FocusState private var focusField : FocusText?
    @State private var emailFieldValue = ""
    @State private var passwordFieldValue = ""
    @State var emailFieldNotFocused = false
    @State var isEmailFieldTouched : Bool = false
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
    
    var isLoginFormValid : Bool{
        if(validators.textFieldValidatorEmail(emailFieldValue) && !passwordFieldValue.isEmpty){
            return true
        }else{
            return false
        }
    }
    
    var body: some View {
      
        NavigationView {
            VStack{
                ZStack{
                    Text("LOG IN").foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("Color").ignoresSafeArea(edges: .top))
                        .frame(maxWidth: .infinity)
                }
                Form{
                    VStack(alignment: .leading, spacing: 20)  {
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
                                    .submitLabel(.done)
                                    .onSubmit() {
                                        login()
                                    }
                                Divider().padding(.trailing, 20)
                            }
                        }
                        HStack{
                            Spacer()
                            Button(action: login) {
                                Text("LOG IN") + Text(Image(systemName: "arrow.right"))
                            }.disabled( !isLoginFormValid).accentColor(.blue)
                            
                            Spacer()
                        }
                        Spacer()
                    }.padding(.leading, 20 ).padding(.top, 30)
                }.alert(authentication.loginErrorMsg, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) {
                        authentication.loginErrorMsg = ""
                    }
                }
                
                if(authentication.loginErrorMsg != "") {
                    Text("").onAppear{
                        showAlert()
                    }
                }
                Spacer()
                NavigationLink("", destination: MainView(isDashboardView: $authentication.isLoggedIn ), isActive: $authentication.isLoggedIn)
            }.gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)}).navigationBarBackButtonHidden(true)
            
        }
        
    }
    private func showAlert() {
        self.showingAlert = true
        
    }
    
    private func login() {
        if(isLoginFormValid){
            authentication.login(email: self.emailFieldValue, password: self.passwordFieldValue)
        }
    }
    
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

