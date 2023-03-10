//
//  JoinButtonView.swift
//  chris-mom-game
//
//  Created by Kesavan Panchabakesan on 02/01/23.
//

import SwiftUI

struct JoinButtonView: View {
    @EnvironmentObject var userDetailService : UserDetailService
    
    var body: some View {
        NavigationView {
            
            VStack{
                Image("giftPic")
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                Spacer()
                Text("Welcome \(self.userDetailService.getCurrentUserName()) to the chris mom chris child game").fontWeight(.bold).foregroundColor(.black).font(.title).frame(width: UIScreen.screenWidth * 0.75).multilineTextAlignment(.center).padding(.bottom)
                Spacer()
                
                Text("Participate to the chris mom chris child game to come out of the shells and help understand each others tastes and act upon the instructions to overcome the shyness.").foregroundColor(.black).font(.callout).frame(width: UIScreen.screenWidth * 0.85).multilineTextAlignment(.center).padding(.bottom)
                Spacer()
                Link("Learn more about chris mom chris child", destination: URL(string: "https://www.deccanchronicle.com/lifestyle/viral-and-trending/191219/whos-giving-me-these-gifts.html#:~:text=It's%20called%20'Secret%20Santa'%20or,see%20who%20the%20donor%20is.")!)
                    .font(.callout)
                    .foregroundColor(.blue).padding(.bottom)
                Spacer()
                HStack{
                    Spacer()
                    
                    Button {
                        self.userDetailService.addingPlayer()
                    } label: {
                        Text("Join").fontWeight(.bold).accentColor(.blue).frame(minWidth: 100, maxWidth: UIScreen.screenWidth * 0.9, minHeight: 50)
                            .background(Color.blue).foregroundColor(.white).cornerRadius(12)
                    }
                    
                    Spacer()
                }
               
            }
            
        }
        
    }
}

struct JoinButtonView_Previews: PreviewProvider {
    static var previews: some View {
        JoinButtonView().environmentObject(UserDetailService())
    }
}
