//
//  ConversationsRepository.swift
//  ChatAppSample
//
//  Created by Abdullah Ansari on 17/05/25.
//

import Foundation

protocol ConversationsRepository {
    
    func fetchConversations(rules: Rules)
    func insertConversation()
    func deleteConversation()
}

enum Rules {
    case cacheThenRemote
    case remoteThenCache
    case onlyRemote
    case onlyCahce
    case onlyRealTime
    case realTimeThenRetmoe
    case realTimeThenRemoteThenCache
}

protocol FetchConversationsRepository {
    func fetchConversations(rules: Rules)
}

//  3 repostiories.

class FetchConversationsRepositoryImpl: FetchConversationsRepository {
    
    
    let localDataSource: LocalDataSource
    let remoteDataSource: RemoteDataSource
    let realTimeDatasource: RealTimeDataSource
    
    init(localDataSource: LocalDataSource, remoteDataSource: RemoteDataSource, realTimeDatasource: RealTimeDataSource) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
        self.realTimeDatasource = realTimeDatasource
    }
    
    func fetchConversations(rules: Rules) {
        switch rules {
        case .cacheThenRemote:
            localDataSource.update()
            remoteDataSource.patchData()
        default:
            break
        }
    }
}

protocol InsertConversationsRepository {
    func insertConversations(rules: Rules)
}

class InsertConversationsRepositoryImpl: InsertConversationsRepository {
    
    let localDataSource: LocalDataSource
    let remoteDataSource: RemoteDataSource
    let realTimeDatasource: RealTimeDataSource
    
    init(localDataSource: LocalDataSource, remoteDataSource: RemoteDataSource, realTimeDatasource: RealTimeDataSource) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
        self.realTimeDatasource = realTimeDatasource
    }
    
    func insertConversations(rules: Rules) {
        localDataSource.update()
    }
}

class ConversationsRepositoryImpl: ConversationsRepository {
    
    let localDataSource: LocalDataSource
    let remoteDataSource: RemoteDataSource
    let realTimeDatasource: RealTimeDataSource
    
    init(localDataSource: LocalDataSource, remoteDataSource: RemoteDataSource, realTimeDatasource: RealTimeDataSource) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
        self.realTimeDatasource = realTimeDatasource
    }
    
    func fetchConversations(rules: Rules) {
        switch rules {
        case .cacheThenRemote:
            localDataSource.update()
            remoteDataSource.patchData()
        default:
            break
        }
    }
    
    func insertConversation() {
        
    }
    
    func deleteConversation() {
        
    }
}
