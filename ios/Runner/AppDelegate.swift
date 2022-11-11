import UIKit
import Flutter
import GoogleMaps
import Firebase
import flutter_local_notifications
import FirebaseMessaging

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    GMSServices.provideAPIKey("AIzaSyCaCSJ0BZItSyXqBv8vpD1N4WBffJeKhLQ")
    FirebaseApp.configure()
      
     FlutterLocalNotificationsPlugin.setPluginRegistrantCallback {
         (registry) in
         GeneratedPluginRegistrant.register(with: registry)
     }
      
      if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
      }
      
      GeneratedPluginRegistrant.register(with: self)
          return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    override func application(_ application:UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken:Data){
        Messaging.messaging().apnsToken=deviceToken
        print("Token:\(deviceToken)")
        super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
}
