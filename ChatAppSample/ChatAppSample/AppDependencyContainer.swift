//
//  AppDependencyContainer.swift
//  ChatAppSample
//
//  Created by Abdullah Ansari on 17/05/25.
//

import Foundation

class AppDependencyContainer: ObservableObject {
    
    static let shared = AppDependencyContainer()
    
    let coreDataManager: CoreDataManager
    let xmppManager: XMPPManager
    let networkManager: NetworkManager
    
    //Data Sources
    let localDataSource: LocalDataSource
    let remoteDataSource: RemoteDataSource
    let realTimeDataSource: RealTimeDataSource
    
    // Repository
    
    let fetchConversationRepo: FetchConversationsRepository
    let insertConversationRepo: InsertConversationsRepository
    
    // Service
    let conversationService: ConversationsService
    
    // Use case.
    let fetchConversationUseCase: FetchConversationUseCase
    let insertConversationUseCase: InsertConversationUseCase
    
    private init() {
        
        coreDataManager = CoreDataManager.shared
        xmppManager = XMPPManagerImpl()
        networkManager = NetworkManagerImpl()
        
        localDataSource = LocalDataSourceImpl(coreDataManager: coreDataManager)
        remoteDataSource = RemoteDataSourceImpl(networkManager: networkManager)
        realTimeDataSource = RealTimeDataSourceImpl(XMPPManager: xmppManager)
        
        fetchConversationRepo = FetchConversationsRepositoryImpl(
            localDataSource: localDataSource,
            remoteDataSource: remoteDataSource,
            realTimeDatasource: realTimeDataSource
        )
        
        insertConversationRepo = InsertConversationsRepositoryImpl(
            localDataSource: localDataSource,
            remoteDataSource: remoteDataSource,
            realTimeDatasource: realTimeDataSource
        )
        
        conversationService = ConversationsServiceImpl(
            fetchConversationRepo: fetchConversationRepo,
            insertInsertRepo: insertConversationRepo
        )
        
        fetchConversationUseCase = FetchConversationUseCaseImpl(
            service: conversationService
        )
        
        insertConversationUseCase = InsertConversationUseCaseImpl(
            service: conversationService
        )
    }
}

extension AppDependencyContainer: ConversationFactory {
    
    func makeConversationView() -> ConversationsView {
        return ConversationsView(viewModel: ConversationViewModelImpl(
            fetchUseCase: fetchConversationUseCase,
            insertUseCase: insertConversationUseCase)
        )
    }
}

extension AppDependencyContainer: MessagesFactory {
    
    func makeMessagesView() -> MessagesView {
        return MessagesView()
    }
}
