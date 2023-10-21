import UIKit
import Flutter
import GoogleMaps
import FirebaseCore

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyB8hEZbjCLkrE8cK_PPX8a7SUaItbL-qiQ")
    GeneratedPluginRegistrant.register(with: self)
     FirebaseApp.configure()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
