//
//  ViewController.swift
//  task2_app
//
//  Created by Recep Uyduran on 30.08.2023.
//

import UIKit
import AVFoundation
import NotificationCenter
import UserNotifications
import MediaPlayer

class ViewController: UIViewController {
    @IBOutlet private weak var timePicker: UIDatePicker!
    @IBOutlet private weak var setAlarmButton: UIButton!

    let current = UNUserNotificationCenter.current()

    @IBAction private func setAlarmButton(_ sender: UIButton) {
        notificationRequst()
    }

    private func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}

extension ViewController {
    private func notificationRequst() {
        var dateComponents = DateComponents()
        let calendar = Calendar.current
        let date = timePicker.date
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        dateComponents.hour = hour
        dateComponents.minute = minute
        triggerRequest(dateComponents: dateComponents)
    }

    private func triggerRequest(
        dateComponents: DateComponents,
        isRepeat: Bool = false
    ) {
        let content = UNMutableNotificationContent()
        let sound = UNNotificationSoundName("task2.mp3")
        content.title = "Wake Up!"
        content.subtitle = "Alarm"
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound(named: sound)

        let uuidString = UUID().uuidString
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: false
        )
        let request = UNNotificationRequest(
            identifier: uuidString,
            content: content,
            trigger: trigger
        )
        current.add(request) { error in
            if(error == nil){
                print("successfully")
            }else{
                print("error")
            }
        }
    }
}
