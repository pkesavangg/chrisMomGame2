//
//  DareDetailsView.swift
//  chris-mom-game
//
//  Created by Kesavan Panchabakesan on 03/01/23.
//

import SwiftUI

struct DareDetailsView: View {
    let playerDetails :  [MemberDetailModel]
    
    init(playerDetails:  [MemberDetailModel]) {
        self.playerDetails = playerDetails
    }
    
    var isDareAvailable : Bool {
        let value = self.playerDetails.filter{ $0.dareMessage != ""}
        return value.count > 0 ? true : false
    }
    
    var body: some View {
        VStack{
            List {
                Section(header: HStack{ Text("Dare Details").fontWeight(.bold).foregroundColor(.blue) }) {
                    if(isDareAvailable){
                        ForEach(self.playerDetails, id: \.self) { item in
                            if(item.childName != ""){
                                DareDetailViewCell(playerDetail: item)
                            }
                        }
                    } else{
                        Text("No one assigned the dare yet")
                    }
                }
            }
            
        }
    }
}


//struct DareDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DareDetailsView()
//    }
//}
