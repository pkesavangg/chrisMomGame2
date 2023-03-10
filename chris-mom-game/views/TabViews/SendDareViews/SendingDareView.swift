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
    
    
    var body: some View {
        VStack{
            ForEach(self.playerDetails, id: \.self) { item in
                if(item.memberMailId == userDetailService.getCurrentUserMailId()){
                    VStack(alignment: .leading){
                        UserInfoView(item: item)
                    }
                }
            }
        }
    }
    
}


struct UserInfoView: View {
    @EnvironmentObject var userDetailService : UserDetailService
    @State var showBanner:Bool?
    @State var bannerData: BannerModifier.BannerData = BannerModifier.BannerData(title: "",  type: .Info)
    
    @State private var showingSheet = false
    var item: MemberDetailModel
    init(item: MemberDetailModel){
        
        self.item = item
        
    }
    
    var body: some View {
        NavigationView {
            List{
                Section(
                    header: Text("User Info")
                ) {
                    HStack{
                        Text("Name")
                        Spacer()
                        Text(item.memberName).foregroundColor(.gray)
                    }
                    HStack{
                        
                        Text("Mail Id")
                        Spacer()
                        Text(item.memberMailId).foregroundColor(.gray)
                        
                    }
                    HStack{
                        
                        Text("Child Name")
                        Spacer()
                        if(item.childName != ""){
                            Text(item.childName).foregroundColor(.gray)
                        }else{
                            Text("Child not assigned yet").foregroundColor(.red)
                        }
                    }
                    
                }
                
                if(item.childName != ""){
                    Section(header:  Text("Send your dare details to your child") ) {
                        HStack{
                            Text("Send dare").sheet(isPresented: $showingSheet) {
                                TextAreaView(playerDetails: item)
                            }
                            Spacer()
                            Image(systemName: "chevron.forward.circle.fill").foregroundColor(.blue).font(.title3)
                        }.onTapGesture {
                            self.showingSheet = true
                        }
                    }
                }
                
                if(self.userDetailService.isDareAssigned(childName: item.childName)){
                    Section(header:  Text("Changing the dare completion status of your child ") ) {
                        
                        VStack{
                            HStack{
                                Spacer()
                                Button {
                                    self.userDetailService.updateCompletionStatus(childName: item.childName)
                                    self.bannerData.title = "Sucess"
                                    self.bannerData.detail = "Sucessfully Update the dare status"
                                    self.bannerData.type = .Success
                                     self.showBanner = true
                                   
                                    
                                }label: {
                                    Text("Toggle completion status")
                                }
                                Spacer()
                            }
                        }
                        
                    }
                    
                }
            }.accentColor(.blue)
            
        }.gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
            .banner(data: $bannerData, show: .constant(self.showBanner) )
    }
}
