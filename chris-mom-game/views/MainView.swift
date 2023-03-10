//
//  MainView.swift
//  chris-mom-game
//
//  Created by Kesavan Panchabakesan on 02/01/23.
//

import SwiftUI

func setNavigationBarBackgroundColor(backgroundColor: UIColor, titleColor: UIColor){
   
    let coloredAppearance = UINavigationBarAppearance()
    coloredAppearance.configureWithTransparentBackground()
    coloredAppearance.backgroundColor = backgroundColor
    coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
    coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]

    UINavigationBar.appearance().standardAppearance = coloredAppearance
    UINavigationBar.appearance().compactAppearance = coloredAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
}


struct MainView: View {
    
    @ObservedObject var authentication = AuthenticationService.shared
    @EnvironmentObject var userDetailService : UserDetailService
    @State private var showingAlert = false
    @Binding var isDashboardView : Bool
    @State private var isLoading = false
    @State private var isParticipating = false
    
  
    
    var body: some View {
        NavigationView {
            VStack{
               
               Text("")
                    .toolbar {
                        Button {
                            Task{
                                showingAlert = true
                            }
                        } label: {
                            Image(systemName: "rectangle.portrait.and.arrow.right").foregroundColor(.white)
                        }.accentColor(.blue).alert(isPresented:$showingAlert) {
                            Alert(
                                title: Text("Are you sure you want to Log out?"),
                                primaryButton: .destructive(Text("Log out")) {
                                    isDashboardView = false
                                    self.authentication.logOut()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                    }.onAppear{
                        setNavigationBarBackgroundColor(backgroundColor: UIColor(Color("Color")), titleColor: .white)
                    }
                    TabViews()
            }.accentColor(.blue) .navigationBarTitle(Text("Dashboard"), displayMode: .inline).onAppear{
                self.userDetailService.getMemberDetails()
            }
        }.navigationBarBackButtonHidden(true)
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView(isDashboardView: .constant(true))
//    }
//}
