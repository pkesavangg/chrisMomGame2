//
//  DareDetailViewCell.swift
//  chris-mom-game
//
//  Created by Kesavan Panchabakesan on 03/01/23.
//

import SwiftUI

struct DareDetailViewCell: View {
    
    @EnvironmentObject var userDetailService : UserDetailService
    let playerDetail :  MemberDetailModel
    init(playerDetail:  MemberDetailModel) {
        self.playerDetail = playerDetail
    }
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Spacer()
                Text("Child Name: ")  +  Text(playerDetail.memberName).foregroundColor(.blue)
                Spacer()
            }
            Spacer()
            HStack{
                HStack(alignment: .top){
                    Text("Task for her/him: ").foregroundColor(.blue).padding(.trailing)
                }
                if(playerDetail.dareMessage != ""){
                    Text(playerDetail.dareMessage)
                }else{
                    Text("Task not assigned yet.")
                }
            }
            Spacer()
            HStack{
                
                if(playerDetail.dareMessage != ""){
                    HStack(alignment: .top){
                        Text("Completion Status").foregroundColor(.blue).padding(.trailing)
                    }
                    if(playerDetail.isCompleted){
                        Text("Completed the dare sucessfuly")
                    }else{
                        Text("Dare not completed")
                    }
                }
            }
            Spacer()
        }
    }
}

//struct DareDetailViewCell_Previews: PreviewProvider {
//    static var previews: some View {
//        DareDetailViewCell()
//    }
//}
