//
//  ConversationsService.swift
//  ChatAppSample
//
//  Created by Abdullah Ansari on 17/05/25.
//

import Foundation

protocol ConversationsService {
    func fetch(rule: Rules)
    func insert()
}

class ConversationsServiceImpl: ConversationsService {
    
    // let repo
    
    private let fetchConversationRepo: FetchConversationsRepository
    private let insertInsertRepo: InsertConversationsRepository
    
    
    init(fetchConversationRepo: FetchConversationsRepository, insertInsertRepo: InsertConversationsRepository) {
        self.fetchConversationRepo = fetchConversationRepo
        self.insertInsertRepo = insertInsertRepo
    }
    
    func fetch(rule: Rules) {
        fetchConversationRepo.fetchConversations(rules: rule)
    }
    
    func insert() {
        insertInsertRepo.insertConversations(rules: .cacheThenRemote)
    }
}
