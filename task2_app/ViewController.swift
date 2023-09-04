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

    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var setAlarmButton: UIButton!

    let current = UNUserNotificationCenter.current()

    override func viewDidLoad() {
        super.viewDidLoad()

        //        timePicker.timeZone = TimeZone.init(identifier: "UTC")
    }

    @IBAction func setAlarmButton(_ sender: UIButton) {
        notificationRequst()
    }

    func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }

}

extension ViewController {

    func notificationRequst() {
        let calendar = Calendar.current
        let date = timePicker.date


        var dateComponents = DateComponents()
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        dateComponents.hour = hour
        dateComponents.minute = minute
        triggerRequest(dateComponents: dateComponents)

    }

    func triggerRequest(dateComponents: DateComponents, isRepeat: Bool = false) {
        let content = UNMutableNotificationContent()
        content.title = "Wake Up!"
        content.subtitle = "Alarm"
        content.categoryIdentifier = "alarm"
        content.sound = UNNotificationSound(named: UNNotificationSoundName("task2.mp3"))

        let uuidString = UUID().uuidString
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content, trigger: trigger)
        current.add(request) { error in
            if(error == nil){
                print("successfully")

            }else{
                print("error")
            }
        }
    }
}
