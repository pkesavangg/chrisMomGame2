//
//  AppDelegate.swift
//  chris-mom-game
//
//  Created by Kesavan Panchabakesan on 02/01/23.
//

import SwiftUI
import UIKit
import FirebaseCore
import FirebaseFirestore
// no changes in your AppDelegate class
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        let database = Firestore.firestore()
        print(">> your code here !!")
        return true
    }
}


@main
struct Testing_SwiftUI2App: App {

    // inject into SwiftUI life-cycle via adaptor !!!
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(UserDetailService())
        }
    }
}
