//
//  Firebase_SwiftUI_MVVMApp.swift
//  Firebase-SwiftUI-MVVM
//
//  Created by Michael Haslam on 5/7/21.
//

import SwiftUI
import Firebase

@main
struct Firebase_SwiftUI_MVVMApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var viewRouter = ViewRouter()
    @StateObject var storyListVM = StoryListViewModel()

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewRouter)
                .environmentObject(storyListVM)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        AuthenticationService.signIn()

        return true
    }
}