//
//  FetchConversationUseCase.swift
//  ChatAppSample
//
//  Created by Abdullah Ansari on 17/05/25.
//

import Foundation

protocol FetchConversationUseCase {
    func execute(rules: Rules)
}


class FetchConversationUseCaseImpl: FetchConversationUseCase {
    
    let service: ConversationsService
    
    init(service: ConversationsService) {
        self.service = service
    }
    
    func execute(rules: Rules) {
        service.fetch(rule: .cacheThenRemote)
    }
}
