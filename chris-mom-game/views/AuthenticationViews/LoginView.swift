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
    @ObservedObject var authentication = AuthenticationService.shared
    @StateObject private var viewModel = LoginViewModel()
    @FocusState private var focusField : FocusText?
    var body: some View {
        
        LoadingView(isShowing: .constant(authentication.isLoading)) {
            NavigationView {
                VStack {
                    
                   
                        VStack {
                           
                            Form {
                                
                                List{
                                    VStack(alignment: .leading, spacing: 20)  {
                                        VStack(alignment: .leading){
                                            Text("Email").font(.callout).foregroundColor(Color(.gray)).fontWeight(.bold)
                                            TextField("xyz@gmail.com" ,text: $viewModel.emailFieldValue,onEditingChanged: { edit in
                                                if edit == false {
                                                    self.viewModel.emailFieldNotFocused = true
                                                }
                                            } ).keyboardType(.emailAddress).disableAutocorrection(true).autocapitalization(.none).accentColor(.blue)
                                                .focused($focusField , equals: .emailField)
                                                .submitLabel(.next)
                                                .onSubmit() {
                                                    focusField = .passwordField
                                                }.onTapGesture {
                                                    self.viewModel.isEmailFieldTouched  = true
                                                }
                                            Divider().padding(.trailing, 20)
                                            
                                            Text( self.viewModel.emailErrorMessage ).font(.caption).foregroundColor(.red)
                                        }
                                        
                                        VStack(alignment: .leading){
                                            VStack(alignment: .leading){
                                                Text("Password").font(.callout).foregroundColor(Color(.gray)).fontWeight(.bold)
                                                SecureField("7845*wdK" , text: $viewModel.passwordFieldValue).accentColor(.blue)
                                                    .focused($focusField , equals: .passwordField)
                                                    .submitLabel(.done)
                                                    .onSubmit() {
                                                        focusField = nil
                                                    }
                                                Divider().padding(.trailing, 20)
                                            }
                                            
                                        }
                                       
                                       
                                    }.padding(.leading, 20 ).padding(.top, 30)
                                }
                                HStack{
                                    Spacer()
                                    Button(action: viewModel.login) {
                                        Text("LOG IN").fontWeight(.bold) + Text(Image(systemName: "arrow.right"))
                                    }.disabled( !viewModel.isLoginFormValid).accentColor(.blue)
                                    
                                    Spacer()
                                } .listRowSeparator(.hidden).padding(.bottom)
                            }
                            .alert(viewModel.loginErrorMsg, isPresented: $viewModel.showAlert) {
                                Button("OK", role: .cancel) {
                                    viewModel.loginErrorMsg = ""
                                }
                            }
                            Spacer()
                            NavigationLink("", destination: MainView(isDashboardView: $authentication.isLoggedIn ), isActive: $authentication.isLoggedIn)
                        }.gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)}).navigationBarBackButtonHidden(true)
                    
                  
                }
               
            }.onAppear{
                setNavigationBarBackgroundColor(backgroundColor: UIColor(Color("Color")), titleColor: .white)
                
            }.navigationBarTitle("LOG IN").navigationBarTitleDisplayMode(.inline)
        }
        
       
        
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


