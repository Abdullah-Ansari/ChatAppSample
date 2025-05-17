//
//  CoreDataSource.swift
//  ChatAppSample
//
//  Created by Abdullah Ansari on 17/05/25.
//

import Foundation

protocol LocalDataSource: DataSource {
    func update()
}

class LocalDataSourceImpl: LocalDataSource {
    
    let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func isDataAvaiable() -> Bool {
        return false
    }
    
    func fetch() {
        
    }
    
    func update() {
        
    }
}
