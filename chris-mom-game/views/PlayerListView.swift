//
//  PlayerListView.swift
//  chris-mom-game
//
//  Created by Kesavan Panchabakesan on 03/01/23.
//

import SwiftUI

struct PlayerListView: View {
    @EnvironmentObject var userDetailService : UserDetailService
    let participantsList :  [MemberDetailModel]
    @State private var showingAlert = false
    init(memberDetails:  [MemberDetailModel]) {
        self.participantsList = memberDetails
    }
    
    var isStartButtonValid : Bool {
        let filtered = participantsList.filter { $0.isParticipating == true }
        if(filtered.count > 2){
            return true
        }
        return false

    }
    
    var isResetButtonValid : Bool {
        let filtered = participantsList.filter { $0.childName != "" }
        if(filtered.count > 0){
            return true
        }
        return false

    }
    @State var showBanner:Bool = false
    @State var bannerData: BannerModifier.BannerData = BannerModifier.BannerData(title: "",  type: .Info)
    var body: some View {
        NavigationView {
            List {
                Section(header: HStack{ Text("Participants List").fontWeight(.bold).foregroundColor(.blue) }) {
                    ForEach(self.participantsList, id: \.self) { item in
                        if(item.isParticipating){
                            Text(item.memberName)
                        }
                    }
                }
                
                if(self.userDetailService.userIsAdmin()){
                    Section(footer:
                                VStack(alignment: .center) {
                        Spacer()
                        HStack{
                            Spacer()
                            Button("Start The Game") {
                              self.userDetailService.generateMomAndChild()
                                self.bannerData.title = "Sucess"
                                self.bannerData.detail = "Sucessfully start the game"
                                self.bannerData.type = .Success
                                self.showBanner = true
                            }.padding().disabled(!isStartButtonValid  || isResetButtonValid )
                            Spacer()
                        }
                        if(self.userDetailService.userIsAdmin()){
                            HStack{
                                Spacer()
                                Button("Reset the game") {
                                    showingAlert = true
                                   
                                }.disabled( !isResetButtonValid).alert(isPresented:$showingAlert) {
                                    Alert(
                                        title: Text("Are you sure you want to Reset the game?"),
                                        primaryButton: .destructive(Text("Reset")) {
                                            self.userDetailService.resetTheGame()
                                            self.bannerData.title = "Sucess"
                                            self.bannerData.detail = "Sucessfully reset the game"
                                            self.bannerData.type = .Success
                                            self.showBanner = true
                                        },
                                        secondaryButton: .cancel()
                                    )
                                }
                                Spacer()
                            }
                        }
                       
                    }) {
                        EmptyView()
                    }
                }
                
                
            }
        }.banner(data: $bannerData, show: $showBanner)
    }
}

//struct PlayerListView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerListView()
//    }
//}
