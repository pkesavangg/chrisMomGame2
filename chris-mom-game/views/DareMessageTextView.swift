//
//  DareMessageTextView.swift
//  chris-mom-game
//
//  Created by Kesavan Panchabakesan on 03/01/23.
//

import SwiftUI



struct DareMessageTextView: View {
    @EnvironmentObject var userDetailService : UserDetailService
var childname = ""
    @FocusState private var focusField : FocusText?


    init(childname: String){
        self.childname = childname
    }
    @State var dareMessage = ""
    var body: some View {
     Text("ddd")
    }
}

struct DareMessageTextView_Previews: PreviewProvider {
    static var previews: some View {
        DareMessageTextView(childname: "")
    }
}
