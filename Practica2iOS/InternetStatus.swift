//
//  InternetStatus.swift
//  Practica2iOS
//
//  Created by Francisco Jaime on 29/05/22.
//

import Foundation
import Network

class InternetStatus: NSObject {
    
    static let instance = InternetStatus()
    
    private override init() {
        super.init()
        monitoring()
    }

    var internetType = ""
    
    private func monitoring() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status != .satisfied {
                self.internetType = "none"
            }
            else {
                if path.usesInterfaceType(.wifi) {
                    self.internetType = "Wifi"
                }
                else if path.usesInterfaceType(.cellular) {
                    self.internetType = "cellular"
                }
            }
        }
        monitor.start(queue: DispatchQueue.global())
    }
}
