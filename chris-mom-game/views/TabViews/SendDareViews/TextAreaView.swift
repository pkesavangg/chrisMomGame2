//
//  LoadingScreenView.swift
//  chris-mom-game
//
//  Created by Kesavan Panchabakesan on 17/01/23.
//

import SwiftUI

struct TextAreaView: View {
    @State private var comment = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userDetailService : UserDetailService
    @State var dareMessage = ""
    @FocusState private var focusField : FocusText?
    let playerDetail :  MemberDetailModel
    
    @State var showBanner:Bool?
    @State var bannerData: BannerModifier.BannerData = BannerModifier.BannerData(title: "",  type: .Info)
    
    init(playerDetails:  MemberDetailModel) {
        self.playerDetail = playerDetails
    }
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading){
                Text("Enter your dare details for your child: ").foregroundColor(.gray).font(.callout).fontWeight(.semibold).padding(.leading).padding(.top)
                
                ZStack{
                    HStack{
                        Spacer()
                        TextEditor(text: $dareMessage).padding().frame(height: 200)
                            .focused($focusField , equals: .emailField).disableAutocorrection(true).accentColor(.blue)
                        Spacer()
                    }
                    
                }.overlay(
                    RoundedRectangle(cornerRadius: 5).stroke(Color(.systemBlue), lineWidth: 2).padding(.leading).padding(.trailing)
                )
                Spacer()
            }.toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(
                        "Cancel"
                    ) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(
                        "Send"
                    ) {
                        focusField = nil
                        self.userDetailService.sendDareMessage(dareMessage: self.dareMessage, childname: playerDetail.childName)
                        self.dareMessage = ""
                        dismiss()
                        self.bannerData.title = "Sucess"
                        self.bannerData.detail = "Sucessfully send the dare to your child"
                        self.bannerData.type = .Success
                        self.showBanner = true
                    }.disabled(dareMessage.trimmingCharacters(in: .whitespaces).isEmpty)
                }
                
                
            }.navigationBarTitle(Text("Send Dare"), displayMode: .inline).accentColor(.white)
            
        }.banner(data: $bannerData, show: $showBanner)
        
        
    }
}

//struct LoadingScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoadingScreenView()
//    }
//}
