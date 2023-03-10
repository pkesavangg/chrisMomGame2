//
//  RegisterView.swift
//  ChrisMom-Chris Child
//
//  Created by Kesavan Panchabakesan on 24/12/22.
//



import SwiftUI


struct RegisterView: View {
    @ObservedObject var authentication = AuthenticationService.shared
    @FocusState private var focusField : FocusText?
    @StateObject private var viewModel = RegisterViewModel()
    var body: some View {
        LoadingView(isShowing: .constant(authentication.isLoading)) {
            NavigationView {
                
                VStack{
                    
                    Form{
                        VStack(alignment: .leading, spacing: 20)  {
                            
                            VStack(alignment: .leading){
                                Text("User name").font(.callout).foregroundColor(Color(.gray)).fontWeight(.bold)
                                TextField("ex: John Cena" ,text: $viewModel.usernameFieldValue,onEditingChanged: { edit in
                                    if edit == false {
                                        self.viewModel.usernameFieldNotFocused = true
                                    }
                                } ).accentColor(.blue).disableAutocorrection(true)
                                    .focused($focusField , equals: .usernameField)
                                    .submitLabel(.next)
                                    .onSubmit() {
                                        focusField = .emailField
                                    }.onTapGesture {
                                        self.viewModel.isUsernameFieldTouched  = true
                                    }
                                Divider().padding(.trailing, 20)
                                
                                Text( self.viewModel.usernameErrorMessage ).font(.caption).foregroundColor(.red)
                            }
                            
                            VStack(alignment: .leading){
                                Text("Email").font(.callout).foregroundColor(Color(.gray)).fontWeight(.bold)
                                TextField("xyz@gmail.com" ,text: $viewModel.emailFieldValue,onEditingChanged: { edit in
                                    if edit == false {
                                        self.viewModel.emailFieldNotFocused = true
                                    }
                                }).keyboardType(.emailAddress).disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .accentColor(.blue)
                                    .focused($focusField , equals: .emailField)
                                    .submitLabel(.next)
                                    .onSubmit() {
                                        focusField = .passwordField
                                    }.onTapGesture {
                                        self.viewModel.isEmailFieldTouched  = true
                                    }
                                Divider()
                                    .padding(.trailing, 20)
                                
                                Text( self.viewModel.emailErrorMessage )
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                            
                            VStack(alignment: .leading){
                                
                                VStack(alignment: .leading){
                                    Text("Password").font(.callout).foregroundColor(Color(.gray)).fontWeight(.bold)
                                    SecureField("7845*wdK" , text: $viewModel.passwordFieldValue).accentColor(.blue)
                                        .focused($focusField , equals: .passwordField)
                                        .submitLabel(.next)
                                        .onSubmit() {
                                            focusField = .confirmPasswordField
                                        }
                                        .onTapGesture {
                                            self.viewModel.isPasswordFieldTouched = true
                                        }
                                    Divider()
                                        .padding(.trailing, 20)
                                    
                                    Text( self.viewModel.passwordErrorMessage )
                                        .font(.caption)
                                        .foregroundColor(.red)
                                }
                                
                            }
                            
                            VStack(alignment: .leading){
                                
                                VStack(alignment: .leading){
                                    Text("Confirm Password").font(.callout).foregroundColor(Color(.gray)).fontWeight(.bold)
                                    SecureField("7845*wdK" , text: $viewModel.confirmPasswordFieldValue).accentColor(.blue)
                                        .focused($focusField , equals: .confirmPasswordField)
                                        .submitLabel(.done)
                                        .onSubmit() {
                                            viewModel.register()
                                        }
                                        .onTapGesture {
                                            self.viewModel.isConfirmPasswordFieldTouched = true
                                        }
                                    Divider()
                                        .padding(.trailing, 20)
                                    
                                    Text( self.viewModel.confirmPasswordErrorMsg )
                                        .font(.caption)
                                        .foregroundColor(.red)
                                }
                            }
                            
                            
                            HStack{
                                Spacer()
                                Button(action: viewModel.register) {
                                    Text("Register").fontWeight(.bold) + Text(Image(systemName: "arrow.right"))
                                }.disabled(!viewModel.isRegisterFormValid)
                                    .accentColor(.blue)
                                Spacer()
                            }
                            
                            Spacer()
                        }.padding(.leading, 20 ).padding(.top, 30)
                    }.alert(viewModel.registerErrorMsg, isPresented: $viewModel.showAlert) {
                        Button("OK", role: .cancel) {
                            viewModel.registerErrorMsg = ""
                        }
                    }
                    
                    Spacer()
                    NavigationLink("", destination: MainView(isDashboardView: $authentication.isLoggedIn ), isActive: $authentication.isLoggedIn)
                    
                    
                }.gesture(DragGesture()
                    .onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
                
                .navigationBarBackButtonHidden(true)
                
            }.navigationTitle("REGISTER").navigationBarTitleDisplayMode(.inline).accentColor(.white).onAppear{
                setNavigationBarBackgroundColor(backgroundColor: UIColor(Color("Color")), titleColor: .white)
                
                
            }
        }

       
    }

    
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

