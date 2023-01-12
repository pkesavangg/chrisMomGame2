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
        VStack{
            VStack{
                Text("Your account details").fontWeight(.bold).foregroundColor(.blue).padding().font(.title)
                VStack(alignment: .leading) {
                    HStack{
                        Text("Username: ")
                        Text(self.userDetailService.getCurrentUserName())
                    }
                    HStack{
                        Text("Email Id: ")
                        Text(self.userDetailService.getCurrentUserMailId())
                    }
                }
            }
            Text("By clicking the button you will join the game").padding()
            
            Button("Join The Game") {
                self.userDetailService.addingPlayer()
            }.accentColor(.blue)
        }
    }
}

struct JoinButtonView_Previews: PreviewProvider {
    static var previews: some View {
        JoinButtonView()
    }
}
