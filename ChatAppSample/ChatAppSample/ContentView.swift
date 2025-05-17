//
//  ContentView.swift
//  ChatAppSample
//
//  Created by Abdullah Ansari on 13/05/25.
//

import SwiftUI

// DataLayer --> DataSource --> Repositories --> Services ---> UseCases --> ViewModel --> View

struct ContentView: View {
    
    @EnvironmentObject private var dependencyContainer: AppDependencyContainer
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button(action: {
               // dependencyContainer.makeConversationView()
                NavigationLink(destination: dependencyContainer.makeConversationView(), label: {
                    
                })
            }, label: {
                Text("Click Me !!")
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
