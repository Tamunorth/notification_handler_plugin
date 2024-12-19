//
//  NotificationTapEventChannel.swift
//  Pods
//
//  Created by Илья Клюкин on 16.12.24.
//

import Flutter
import UIKit

class NotificationTapStreamHandler: NSObject, FlutterStreamHandler, UNUserNotificationCenterDelegate {
    private var eventSink: FlutterEventSink?
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSink = nil
        return nil
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let content = response.notification.request.content
        
        let notificationData: [String: Any] = [
            "title": content.title,
            "body": content.body,
            "payload":  content.userInfo
        ]
        
        self.eventSink?(notificationData)
        
        completionHandler()
    }
}
