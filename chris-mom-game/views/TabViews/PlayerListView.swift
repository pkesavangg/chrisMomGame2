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
    @State private var showingStartAlert = false
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
    @State var showBanner:Bool?
    @State var bannerData: BannerModifier.BannerData = BannerModifier.BannerData(title: "",  type: .Info)
    var body: some View {
        NavigationView {
       
            
            List {
                
                Section(header: HStack{ Text("Participants names:") }) {
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
                            Button("Start the game") {
                                showingStartAlert = true
                             
                            }.padding()
                                .disabled(!isStartButtonValid  || isResetButtonValid )
                                .buttonStyle(.borderedProminent).alert(isPresented:$showingStartAlert) {
                                Alert(
                                    title: Text("Are you sure you want to Start the game?"),
                                    primaryButton: .default(Text("Start"))  {
                                        self.userDetailService.generateMomAndChild()
                                        self.bannerData.title = "Sucess"
                                        self.bannerData.detail = "Sucessfully Start the game"
                                        self.bannerData.type = .Success
                                        self.showBanner = true
                                    },
                                    secondaryButton: .cancel()
                                )
                            }
                            Spacer()
                        }
                        if(self.userDetailService.userIsAdmin()){
                            HStack{
                                Spacer()
                                
                                Button("Reset the game") {
                                    showingAlert = true
                                   
                                }.buttonStyle(.borderedProminent)
                                    .disabled( !isResetButtonValid)
                                    .alert(isPresented:$showingAlert) {
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
            
        }.banner(data: $bannerData, show: $showBanner).accentColor(.blue)
    }
}

//struct PlayerListView_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerListView()
//    }
//}
