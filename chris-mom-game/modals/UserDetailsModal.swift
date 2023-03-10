//
//  UserDetailsModal.swift
//  chris-mom-game
//
//  Created by Kesavan Panchabakesan on 02/01/23.
//

import Foundation

struct MemberDetailModel: Hashable, Codable {
    let id = UUID()
    var memberName : String
    var memberMailId : String
    var documentId: String = ""
    var isParticipating : Bool = false
    var childName: String = ""
    var dareMessage: String = ""
    var isCompleted: Bool = false
}


struct BannerData {
    var title:String
    var detail:String
}
