//
//  XMPPDataSource.swift
//  ChatAppSample
//
//  Created by Abdullah Ansari on 17/05/25.
//

import Foundation

protocol RealTimeDataSource: DataSource {
    
    // Declare respective methods
    
    func realTimeFetch()
}

class RealTimeDataSourceImpl: RealTimeDataSource {
    func fetch() {
        
    }
    
    func isDataAvaiable() -> Bool {
        return true
    }
    
    private let XMPPManager: XMPPManager
    
    init(XMPPManager: XMPPManager) {
        self.XMPPManager = XMPPManager
    }
    
    func realTimeFetch() {
        XMPPManager.realTimeFetch()
    }
    
    
}
