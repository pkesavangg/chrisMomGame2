//
//  LandingPage.swift
//  ChrisMom-Chris Child
//
//  Created by Kesavan Panchabakesan on 24/12/22.
//

import SwiftUI
extension View {
    func border(_ color: Color, width: CGFloat, cornerRadius: CGFloat) -> some View {
        overlay(RoundedRectangle(cornerRadius: cornerRadius).stroke(color, lineWidth: width))
    }
}

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
                  
                    Button("REGISTER") {
                        showRegisterView()
                        print("Button pressed!")
                    }
                    .foregroundColor(Color("Color"))
                    .clipShape(Capsule())
                    .frame(width: 331, height: 88)
                    .background(.white).cornerRadius(45)
                    .font(.system(size: 35))
                    .frame(width: UIScreen.screenSize.width * 0.7, height: UIScreen.screenSize.height * 0.074)
                    .background(Color("secondary-color")).cornerRadius(UIScreen.screenSize.width * 0.8)
                    .font(.system(size: UIScreen.screenSize.width * 0.11)) .border(Color.white, width: 2, cornerRadius: UIScreen.screenSize.width * 0.8)
                    .minimumScaleFactor(0.5)
                    NavigationLink("", destination: LoginView(), isActive: $isLoginViewNavigated)
                    NavigationLink("", destination: RegisterView(), isActive: $isRegisterViewNavigated)
                    Button("LOG IN") {
                        showLoginView()
                        print("Button pressed!")
                    }
                    .foregroundColor(Color.white)
                    .clipShape(Capsule())
                    .frame(width: 331, height: 88)
                    .background(Color("Color")).cornerRadius(45)
                    .font(.system(size: 35))
                    .frame(width: UIScreen.screenSize.width * 0.7, height: UIScreen.screenSize.height * 0.07)
                    .cornerRadius(UIScreen.screenSize.width * 0.8)
                    .font(.system(size: UIScreen.screenSize.width * 0.11))
                    .minimumScaleFactor(0.5)
                    .border(Color.white, width: 2, cornerRadius: UIScreen.screenSize.width * 0.8)

                    Spacer()
                }
                Spacer()
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

