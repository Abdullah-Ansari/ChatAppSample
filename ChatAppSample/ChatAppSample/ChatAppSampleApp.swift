//
//  ChatAppSampleApp.swift
//  ChatAppSample
//
//  Created by Abdullah Ansari on 13/05/25.
//

import SwiftUI

@main
struct ChatAppSampleApp: App {
    
    @StateObject private var appDependencyContainer: AppDependencyContainer = AppDependencyContainer.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appDependencyContainer)
        }
    }
}
