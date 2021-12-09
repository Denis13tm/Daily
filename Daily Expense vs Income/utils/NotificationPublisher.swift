

import UserNotifications
import UIKit

class NotificationPublisher: NSObject {
    
    func send_N(title: String, body: String, badge: Int?, hour: Int?, min: Int?, useerN: UNUserNotificationCenter) {
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.hour = hour
        dateComponents.minute = min
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        if let badge = badge {
            var currentBudgeCount = UIApplication.shared.applicationIconBadgeNumber
            currentBudgeCount += badge
            notificationContent.badge = NSNumber(integerLiteral: currentBudgeCount)
        }
        
        notificationContent.sound = UNNotificationSound.default
        
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: notificationContent, trigger: trigger)
        print("\(uuidString)")
        
    useerN.add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
    }
    
}



extension NotificationPublisher: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .sound, .alert])
    }
    
    
    

    
}
