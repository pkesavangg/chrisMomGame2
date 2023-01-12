//
//  MainView.swift
//  chris-mom-game
//
//  Created by Kesavan Panchabakesan on 02/01/23.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var authentication = AuthenticationService()
    @EnvironmentObject var userDetailService : UserDetailService
    @State private var showingAlert = false
    @Binding var isDashboardView : Bool
    
    var body: some View {
        NavigationView {
            VStack{
                ZStack{
                    Text("Dashboard View").foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("Color").ignoresSafeArea(edges: .top))
                        .frame(maxWidth: .infinity)
                }
                Spacer()
                    .toolbar {
                        Button {
                            Task{
                                showingAlert = true
                            }
                        } label: {
                            Text("LOG OUT").foregroundColor(.white)
                        }.accentColor(.blue).alert(isPresented:$showingAlert) {
                            Alert(
                                title: Text("Are you sure you want to Log out?"),
                                primaryButton: .destructive(Text("Log out")) {
                                    isDashboardView = false
                                    authentication.logOut()
                                },
                                secondaryButton: .cancel()
                            )
                        }
                    }
                if(self.userDetailService.checkCurrentUserIsParticipating()){
                    TabViews()
                }else{
                    JoinButtonView()
                    Spacer()
                }
//                Spacer()
            }
        }.onAppear {
            self.userDetailService.getMemberDetails()
        }.navigationBarBackButtonHidden(true)
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
