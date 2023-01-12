//
//  SendingDareViewCell.swift
//  chris-mom-game
//
//  Created by Kesavan Panchabakesan on 03/01/23.
//

import SwiftUI


struct SendingDareViewCell: View {
    @EnvironmentObject var userDetailService : UserDetailService
    let playerDetail :  MemberDetailModel
    @State var dareMessage = ""
    @FocusState private var focusField : FocusText?
    @State var showBanner:Bool = false
    @State var bannerData: BannerModifier.BannerData = BannerModifier.BannerData(title: "",  type: .Info)
    init(playerDetails:  MemberDetailModel) {
        self.playerDetail = playerDetails
    }
    var body: some View {
      
            VStack(alignment: .leading){
                HStack{
                    Text("Mom Name: ")
                    Text(playerDetail.memberName).foregroundColor(.blue)
                    Spacer()
                }
                HStack{
                    Text("Child Name: ")
                    if(playerDetail.childName != ""){
                        Text(playerDetail.childName).foregroundColor(.blue)
                    }else{
                        Text("Child not assigned yet").foregroundColor(.red)
                    }
                    Spacer()
                }
                
                VStack{
                    Text("Enter your dare details for your child: ").foregroundColor(.blue)
                    
                    ZStack{
                        TextEditor(text: $dareMessage)
                            .focused($focusField , equals: .emailField)
                        Text(dareMessage).opacity(0).padding(.all,28)
                    }.border(.blue).overlay(
                        RoundedRectangle(cornerRadius: 5).stroke(Color(.systemBlue), lineWidth: 2)
                    )
                    Spacer()
                    Button("Send Dare") {
                        focusField = nil
                        self.userDetailService.sendDareMessage(dareMessage: self.dareMessage, childname: playerDetail.childName)
                        self.bannerData.title = "Sucess"
                        self.bannerData.detail = "Sucessfully send the dare details to your chiild"
                        self.bannerData.type = .Success
                        self.showBanner = true
                    }.disabled(self.dareMessage.isEmpty || dareMessage.trimmingCharacters(in: .whitespaces).isEmpty ).padding()
                    
                }
            }.banner(data: $bannerData, show: $showBanner)
    }
}
//struct SendingDareViewCell_Previews: PreviewProvider {
//    static var previews: some View {
//        SendingDareViewCell()
//    }
//}
