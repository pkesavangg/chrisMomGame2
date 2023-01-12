//
//  UserDetailService.swift
//  chris-mom-game
//
//  Created by Kesavan Panchabakesan on 02/01/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserDetailService : ObservableObject{
    let dataBase = Firestore.firestore()
    let userDefaults = UserDefaults.standard
    
    @Published var playerDetails = [MemberDetailModel]()
    
    func getCurrentUserName() -> String{
        return  UserDefaults.standard.string(forKey: "userName") ?? ""
    }
    
    func getCurrentUserMailId() -> String{
        if let currentUserId = Auth.auth().currentUser?.email{
            return currentUserId
        }
        return ""
    }
    
    func checkCurrentUserIsParticipating() -> Bool {
        if(playerDetails.count > 0){
            if  let value =  playerDetails.first(where: {$0.isParticipating == true && $0.memberMailId == getCurrentUserMailId()}) {
                if(value.isParticipating == true){
                    return true
                }
            }
        }
        return false
    }
    
    func getCurrentUserdocumentId() -> String {
        return UserDefaults.standard.string(forKey: "currentUserDocumentId") ?? ""
    }
    
    func userIsAdmin() -> Bool {
        if let userId = Auth.auth().currentUser?.email{
            if(userId == "karthick@gmail.com"){
                return true
            }
        }
        return false
    }
    
    func getDocumentId(membername : String) -> String{
        
        if let value = playerDetails.first(where: {$0.memberName == membername}) {
            if(value.documentId != nil){
                return value.documentId
            }
        }
        return ""
        
    }
    
    func addingPlayer(){
        dataBase.collection(Strings.FBase.memberDetails).document(getCurrentUserdocumentId())
            .setData([Strings.FBase.isParticipating: true] ,merge: true) { (error) in
                if let e = error {
                    print("There was and issue, \(e)")
                    print("There was and issue")
                }else{
                    DispatchQueue.main.async {
                        print("SuccessFully added the player \(self.getCurrentUserName())")
                    }
                    
                }
            }
    }
    
    
    func isDareAssigned(childName : String) -> Bool{
        if let value = playerDetails.first(where: {$0.memberName == childName}) {
            if(value.dareMessage != ""){
                return true
            }
        }
        return false
    }
    
    
    
    func generateMomAndChild(){
        var boolValue = true
        
        if( self.playerDetails.count < 2){
            return
        }
        var childNames = [String : String]()
        
        let participantsList =  playerDetails.filter { $0.isParticipating == true }
        
        for player in participantsList {
            boolValue = true
            while(boolValue == true){
                let randomNumber = Int.random(in: 0 ... participantsList.count - 1)
                if( !childNames.contains(where: {$0.value == participantsList[randomNumber].memberName})  && participantsList[randomNumber].memberName != player.memberName ){
                    childNames.updateValue( participantsList[randomNumber].memberName, forKey: player.memberName)
                    boolValue = false
                }
            }
        }
        sendMomAndChildDetails(childNames: childNames)
    }
    
    func sendMomAndChildDetails(childNames : [String : String]){
        for (memberName, childName) in childNames {
            dataBase.collection(Strings.FBase.memberDetails).document(getDocumentId(membername: memberName))
                .setData([Strings.FBase.childName: childName] ,merge: true) { (error) in
                    if let e = error {
                        print("There was and issue, \(e)")
                        print("There was and issue")
                    }else{
                        DispatchQueue.main.async {
                            print("SuccessFully added the player \(self.getCurrentUserName())")
                        }
                        
                    }
                }
        }
    }
    
    func sendDareMessage(dareMessage: String, childname: String){
        print(dareMessage, childname)
        
        dataBase.collection(Strings.FBase.memberDetails).document(getDocumentId(membername: childname))
            .setData([Strings.FBase.dareMessage: dareMessage] ,merge: true) { (error) in
                if let e = error {
                    print("There was and issue, \(e)")
                    print("There was and issue")
                }else{
                    DispatchQueue.main.async {
                        print("SuccessFully send the dare message \(dareMessage)")
                    }
                    
                }
            }
        
    }
    
    func getDareCompletionStatus(childname: String) -> Bool {
        var completionStatus = false
        
        if let value = playerDetails.first(where: {$0.memberName == childname}) {
            if(value.isCompleted){
                completionStatus = false
            }else{
                completionStatus = true
            }
        }
        return completionStatus
    }
    
    func resetTheGame(){
        
        for player in playerDetails {
            
            dataBase.collection(Strings.FBase.memberDetails).document(player.documentId)
                .setData([Strings.FBase.isParticipating: false, Strings.FBase.childName : "", Strings.FBase.isCompleted : false,  Strings.FBase.dareMessage : "",] ,merge: true) { (error) in
                    if let e = error {
                        print("There was and issue, \(e)")
                        print("There was and issue")
                    }else{
                        DispatchQueue.main.async {
                            print("SuccessFully send the dare message ")
                        }
                        
                    }
                }
            
        }
        
    }
    
    func updateCompletionStatus(childName : String) {
        
        var completionStatus = getDareCompletionStatus(childname: childName)
        
        dataBase.collection(Strings.FBase.memberDetails).document(getDocumentId(membername: childName))
            .setData([Strings.FBase.isCompleted: completionStatus] ,merge: true) { (error) in
                if let e = error {
                    print("There was and issue, \(e)")
                    print("There was and issue")
                }else{
                    DispatchQueue.main.async {
                        print("SuccessFully Send the completion status \(completionStatus)")
                    }
                    
                }
            }
    }
    
    func getMemberDetails(){
        dataBase.collection(Strings.FBase.memberDetails)
            .order(by: Strings.FBase.dateField)
            .addSnapshotListener{ (querySnapshot , error ) in
                if let e = error {
                    print("There was an issue retrieving data from firestore \(e)")
                }else{
                    if let snapShotDocuments =  querySnapshot?.documents {
                        self.playerDetails = []
                        
                        for doc in snapShotDocuments {
                            let data = doc.data()
                            if let userId = data[Strings.FBase.memberMailId] as? String ,
                               let userName = data[Strings.FBase.memberName] as? String,
                               let documentId = data[Strings.FBase.documentId] as? String,
                               let isParticipating = data[Strings.FBase.isParticipating] as? Bool,
                               let childName = data[Strings.FBase.childName] as? String,
                               let dareMessage = data[Strings.FBase.dareMessage] as? String,
                               let isCompleted = data[Strings.FBase.isCompleted] as? Bool
                            {
                                if ( userId == self.getCurrentUserMailId()){
                                    self.userDefaults.set(userName, forKey: "userName")
                                    self.userDefaults.set(documentId, forKey: "currentUserDocumentId")
                                }
                                self.playerDetails.append(MemberDetailModel(memberName: userName, memberMailId: userId, documentId: documentId,
                                                                            isParticipating: isParticipating, childName: childName, dareMessage: dareMessage, isCompleted: isCompleted))
                            }
                        }
                    }
                }
            }
    }
    
    func sendUserDetailsInfo(userName : String, userEmailId: String) {
        let newDocument = dataBase.collection(Strings.FBase.memberDetails).document()
        
        newDocument.setData([Strings.FBase.memberMailId: userEmailId,
                             Strings.FBase.memberName: userName,
                             Strings.FBase.dateField: Date.timeIntervalSinceReferenceDate,
                             Strings.FBase.documentId : newDocument.documentID,
                             Strings.FBase.isParticipating : false,
                             Strings.FBase.childName : "",
                             Strings.FBase.dareMessage : "",
                             Strings.FBase.isCompleted : false
                            ]) { (error) in
            if let e = error {
                print("There was and issue, \(e)")
                print("There was and issue")
            }else{
                DispatchQueue.main.async {
                    
                }
                print("SuccessFully send the Users list")
            }
        }
    }
    
    
}
