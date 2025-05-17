//
//  ConversationsView.swift
//  ChatAppSample
//
//  Created by Abdullah Ansari on 17/05/25.
//

import Foundation
import SwiftUI

protocol MessagesFactory {
    func makeMessagesView() -> MessagesView
}

struct MessagesView: View {
    var body: some View {
        Text("Hi")
    }
}

protocol ConversationFactory {
    func makeConversationView() -> ConversationsView
}

struct ConversationsView: View {
    
    @State var viewModel: ConversationViewModel
    
    @EnvironmentObject private var dependencyContainer: AppDependencyContainer
    
    var body: some View {
        Text("ConversationView")
    }
}


#Preview {
    AppDependencyContainer.shared.makeConversationView()
}
