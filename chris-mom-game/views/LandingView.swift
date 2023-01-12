//
//  LandingPage.swift
//  ChrisMom-Chris Child
//
//  Created by Kesavan Panchabakesan on 24/12/22.
//

import SwiftUI


extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
struct LandingView: View {
    
    @State var isLoginViewNavigated = false
    @State var isRegisterViewNavigated = false
    var body: some View {
        NavigationView {
            ZStack{
                Color("Color").edgesIgnoringSafeArea(.all)
                VStack{
                    Spacer()
                    Image("splashScreenImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 313, height: 313)
                    Spacer()
                    
                  
                    Button("REGISTER") {
                        showRegisterView()
                        print("Button pressed!")
                    }
                    .foregroundColor(Color("Color"))
                    .clipShape(Capsule())
                    .frame(width: 331, height: 88)
                    .background(.white).cornerRadius(45)
                    .font(.system(size: 40))
                    .frame(width: UIScreen.screenSize.width * 0.7, height: UIScreen.screenSize.height * 0.1)
                    .background(Color("secondary-color")).cornerRadius(UIScreen.screenSize.width * 0.8)
                    .font(.system(size: UIScreen.screenSize.width * 0.11))
                    .minimumScaleFactor(0.5)
                    NavigationLink("", destination: LoginView(), isActive: $isLoginViewNavigated)
                    NavigationLink("", destination: RegisterView(), isActive: $isRegisterViewNavigated)
                    Button("LOG IN") {
                        showLoginView()
                        print("Button pressed!")
                    }
                    .foregroundColor(Color("Color"))
                    .clipShape(Capsule())
                    .frame(width: 331, height: 88)
                    .background(Color(.white)).cornerRadius(45)
                    .font(.system(size: 40))
                    .frame(width: UIScreen.screenSize.width * 0.7, height: UIScreen.screenSize.height * 0.1)
                    .background(Color(.blue)).cornerRadius(UIScreen.screenSize.width * 0.8)
                    .font(.system(size: UIScreen.screenSize.width * 0.11))
                    .minimumScaleFactor(0.5)
                    Spacer()
                }
            }.navigationViewStyle(StackNavigationViewStyle()) .edgesIgnoringSafeArea(.all)
                
            
        }
    }
    
    private func showLoginView() {
        self.isLoginViewNavigated = true
    }
    private func showRegisterView() {
        self.isRegisterViewNavigated = true
    }
}

struct LandingPage_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}

