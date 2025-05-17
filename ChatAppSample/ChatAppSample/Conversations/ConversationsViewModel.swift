//
//  ConversationsViewModel.swift
//  ChatAppSample
//
//  Created by Abdullah Ansari on 17/05/25.
//

import Foundation

protocol ConversationViewModel {
    
    func fetchConversation()
    func insertConversation(_ message: String)
}

@Observable
class ConversationViewModelImpl: ConversationViewModel {
    
    private let fetchUseCase: FetchConversationUseCase
    private let insertUseCase: InsertConversationUseCase
    
    var conversations: [String] = []
    
    init(
        fetchUseCase: FetchConversationUseCase, insertUseCase: InsertConversationUseCase) {
        self.fetchUseCase = fetchUseCase
        self.insertUseCase = insertUseCase
    }
    
    func fetchConversation() {
        fetchUseCase.execute(rules: .realTimeThenRetmoe)
    }
    
    func insertConversation(_ message: String) {
        insertUseCase.execute()
    }
    
}
