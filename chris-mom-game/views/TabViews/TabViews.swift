//
//  TabView.swift
//  chris-mom-game
//
//  Created by Kesavan Panchabakesan on 03/01/23.
//

import SwiftUI

struct TabViews: View {
    @EnvironmentObject var userDetailService : UserDetailService
    
    init() {
           UITabBar.appearance().backgroundColor = UIColor(Color("Color"))
           UITabBar.appearance().unselectedItemTintColor = UIColor(Color("t"))
       }
    
    var body: some View {
        
        if(!self.userDetailService.checkCurrentUserIsParticipating() ){
            JoinButtonView()
        }else{
            TabView {
               
                    PlayerListView(memberDetails: self.userDetailService.playerDetails).tabItem {
                        Label("Participants", systemImage: "person.crop.circle.fill")
                    }
                   
                    DareListView(playerDetails: self.userDetailService.playerDetails).tabItem {
                        Label("Dare Details", systemImage: "list.bullet.circle.fill")
                    }
                    SendingDareView(playerDetails: self.userDetailService.playerDetails).tabItem {
                        Label("Send Dare", systemImage: "paperplane.circle.fill")
                    }
                
                
               
            }.accentColor(Color(.white)).background(.white)
        }
        
        
    }
}


//struct TabViews_Previews: PreviewProvider {
//    static var previews: some View {
//        TabViews()
//    }
//}
