import Flutter
import UIKit

public class NotificationHandlerPlugin: NSObject, FlutterPlugin {
    
    private var tapStreamHandler: NotificationTapStreamHandler?
    
    private var initialNotification: [AnyHashable: Any]?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let eventChannel = FlutterEventChannel(name: "notification_tap_event", binaryMessenger: registrar.messenger())
        let tapStreamHandler = NotificationTapStreamHandler()
        eventChannel.setStreamHandler(tapStreamHandler)
        
        
        UNUserNotificationCenter.current().delegate = tapStreamHandler
        
        let instance = NotificationHandlerPlugin()
        instance.tapStreamHandler = tapStreamHandler
        registrar.addApplicationDelegate(instance)
        
        let methodChannel = FlutterMethodChannel(name: "notificaiton_plugin_channel", binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(instance, channel: methodChannel)
    }
    
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [AnyHashable : Any] = [:]) -> Bool {
        
        if let notificationOption = launchOptions[UIApplication.LaunchOptionsKey.remoteNotification] as? [AnyHashable: Any] {
            initialNotification = notificationOption
        }
        
        return true
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "get_initial_message" {
            result(initialNotification)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
}
