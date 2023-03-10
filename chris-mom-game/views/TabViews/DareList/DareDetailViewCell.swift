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
                Text("Child name: ").fontWeight(.semibold)
                Spacer()
                Text(playerDetail.memberName).foregroundColor(.orange)
            }
            
            Spacer()
            
            HStack{
                HStack(alignment: .top){
                    Text("Task for her/him: ").fontWeight(.semibold)
                }
                
                Spacer()
                
                if(playerDetail.dareMessage != ""){
                    Text(playerDetail.dareMessage).multilineTextAlignment(.center)
                }else{
                    Text("Task not assigned yet.").foregroundColor(.orange).multilineTextAlignment(.center)
                }
            }
            
            Spacer()
            
            HStack{
                HStack(alignment: .top){
                    Text("Completion Status:").fontWeight(.semibold).padding(.trailing)
                }
                
                Spacer()
                
                if(playerDetail.isCompleted){
                    Text("Completed sucessfuly").foregroundColor(.green)
                }else{
                    Text("Not completed").foregroundColor(.orange)
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
