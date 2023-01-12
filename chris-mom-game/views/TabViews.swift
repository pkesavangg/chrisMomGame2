//
//  TabView.swift
//  chris-mom-game
//
//  Created by Kesavan Panchabakesan on 03/01/23.
//

import SwiftUI

struct TabViews: View {
    @EnvironmentObject var userDetailService : UserDetailService
    
    var body: some View {
        TabView {
            PlayerListView(memberDetails: self.userDetailService.playerDetails).tabItem {
                Label("Participants List", systemImage: "person.crop.circle.fill")
            }
            SendingDareView(playerDetails: self.userDetailService.playerDetails).tabItem {
                Label("Send Dare", systemImage: "paperplane.circle.fill")
            }
            DareDetailsView(playerDetails: self.userDetailService.playerDetails).tabItem {
                Label("Dare Details", systemImage: "list.bullet.circle.fill")
            }
        }.accentColor(.blue)
    }
}


//struct TabViews_Previews: PreviewProvider {
//    static var previews: some View {
//        TabViews()
//    }
//}
