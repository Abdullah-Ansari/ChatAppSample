//
//  NetworkDataSource.swift
//  ChatAppSample
//
//  Created by Abdullah Ansari on 17/05/25.
//

import Foundation

protocol DataSource {
    // common methods
    func fetch()
    func isDataAvaiable() -> Bool
}

protocol RemoteDataSource: DataSource {
    
    // methods
    func patchData()
}

class RemoteDataSourceImpl: RemoteDataSource {
    func patchData() {
        
    }
    
    func fetch() {
        
    }
    
    func isDataAvaiable() -> Bool {
        return true 
    }
    
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchData() {
        networkManager.fetch(URL(string: "")!)
    }
}
