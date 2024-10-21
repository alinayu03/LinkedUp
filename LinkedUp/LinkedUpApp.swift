//
//  LinkedUpApp.swift
//  LinkedUp
//
//  Created by Alina Yu on 10/20/24.
//

import SwiftUI
import Firebase

@main
struct LinkedUpApp: App {
    init() {
        FirebaseApp.configure()  // Initialize Firebase
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
