//
//  SendingDareView.swift
//  chris-mom-game
//
//  Created by Kesavan Panchabakesan on 03/01/23.
//

import SwiftUI


struct SendingDareView: View {
    @EnvironmentObject var userDetailService : UserDetailService
    let playerDetails :  [MemberDetailModel]
    
    init(playerDetails:  [MemberDetailModel]) {
        self.playerDetails = playerDetails
    }
    @State var showBanner:Bool = false
    @State var bannerData: BannerModifier.BannerData = BannerModifier.BannerData(title: "",  type: .Info)
    
    var body: some View {
        
        List{
            Section(header: HStack{ Text("Participants List").fontWeight(.bold).foregroundColor(.blue) }) {
                ForEach(self.playerDetails, id: \.self) { item in
                    if(item.memberMailId == userDetailService.getCurrentUserMailId()){
                        SendingDareViewCell(playerDetails: item)
                        if(self.userDetailService.isDareAssigned(childName: item.childName)){
                            VStack{
                                Text("Change dare completion status of your child")
                                  
                                    Button {
                                        self.userDetailService.updateCompletionStatus(childName: item.childName)
                                        self.bannerData.title = "Sucess"
                                        self.bannerData.detail = "Sucessfully change the dare status"
                                        self.bannerData.type = .Success
                                        self.showBanner = true
                                    } label: {
                                        Text("Change Status")
                                    }
                                
                            }
                        }
                    }
                }
            }
        }.banner(data: $bannerData, show: $showBanner)
    }
}

//struct SendingDareView_Previews: PreviewProvider {
//    static var previews: some View {
//        SendingDareView()
//    }
//}
