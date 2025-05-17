//
//  InsertConversationUseCase.swift
//  ChatAppSample
//
//  Created by Abdullah Ansari on 17/05/25.
//

import Foundation

protocol InsertConversationUseCase {
    func execute()
}

class InsertConversationUseCaseImpl: InsertConversationUseCase {
    
//    let conversationRepo: ConversationsRepository
    let service: ConversationsService
    
    init(service: ConversationsService) {
        self.service = service
    }
    
    func execute() {
        service.insert()
        service.fetch(rule: .onlyCahce)
    }
    
}

