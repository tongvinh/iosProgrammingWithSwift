//
//  WatchManager.swift
//  AppleWatchExample
//
//  Created by Nguyen Duc Hoang on 9/25/18.
//  Copyright © 2018 Nguyen Duc Hoang. All rights reserved.
//

import Foundation
import WatchConnectivity
class WatchManager: NSObject {
    static let shared: WatchManager = WatchManager()
    fileprivate var watchSession: WCSession?
    override init() {
        super.init()
        if (!WCSession.isSupported()) {
            watchSession = nil
            return
        }
        watchSession = WCSession.default
        watchSession?.delegate = self // We don't really need this, we'll just use it for debug.
        watchSession?.activate()        
    }
    func sendParamsToWatch(dict: [String: Any]) {
        do {
            try watchSession?.updateApplicationContext(dict)
        } catch {
            print("Error sending dictionary \(dict) to Apple Watch!")
        }
    }
}
// MARK: WCSessionDelegate
extension WatchManager: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("activationDidComplete")
    }
    
    public func sessionDidBecomeInactive(_ session: WCSession) {
        print("sessionDidBecomeInactive")
    }
    
    public func sessionDidDeactivate(_ session: WCSession) {
        print("sessionDidDeactivate")
    }
}
