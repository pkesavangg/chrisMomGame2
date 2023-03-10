//
//  ContentView.swift
//  ChrisMom-Chris Child
//
//  Created by Kesavan Panchabakesan on 23/12/22.
//

import SwiftUI
import CoreData
import FirebaseAuth

struct ContentView: View {
    @ObservedObject var authentication = AuthenticationService.shared
    @EnvironmentObject var userDetailService : UserDetailService
    var body: some View {
        VStack{
            if(authentication.isLoggedIn){
                MainView(isDashboardView: $authentication.isLoggedIn)
            }else{
                LandingView()
            }
        }
        .onAppear{
           
            Auth.auth().addStateDidChangeListener { auth, user in
                
                if(user != nil ){
                    self.authentication.isLoggedIn = true
                }else{
                    self.authentication.isLoggedIn = false
                }
            }
        }
    }
}



//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

