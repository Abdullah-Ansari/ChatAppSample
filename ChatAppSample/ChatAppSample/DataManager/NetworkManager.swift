//
//  NetworkManager.swift
//  ChatAppSample
//
//  Created by Abdullah Ansari on 17/05/25.
//

import Foundation

protocol NetworkManager {
    
    func fetch(_ url: URL)
}

class NetworkManagerImpl: NetworkManager {
    
    func fetch(_ url: URL) {
        
    }
}
