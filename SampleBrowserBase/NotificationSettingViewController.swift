//
//  NotificationSettingViewController.swift
//  SampleBrowserBase
//
//  Created by apple on 2018/09/20.
//  Copyright © 2018年 com.nainai0722. All rights reserved.
//

import UIKit
import UserNotifications
class NotificationSettingViewController: UIViewController {

    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var notificationButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onNotificationButtonTapped(_ sender: UIButton) {
        
        let center = UNUserNotificationCenter.current()
        
        let date = datePicker.date

        center.requestAuthorization(options: [.alert,.sound], completionHandler: { granted, error in
            if error != nil {
                let controller = UIAlertController(title: nil, message: "通知設定時にエラーが発生しました", preferredStyle: UIAlertControllerStyle.alert)
                controller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
                self.present(controller, animated:true ,completion: nil)
                return
            }
            if granted {
                center.removeAllPendingNotificationRequests()
                
                let content = UNMutableNotificationContent()
                
                content.title = "最新の記事をチェックしよう"
                
                content.subtitle = "今日はもう記事をチェックしましたか?"
                content.body = "最新のニュースがありますよ"
                
                content.sound = UNNotificationSound.default()
                
                let calender = Calendar.current
                
                let dateComponents = calender.dateComponents([.hour, .minute],  from: date)
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                
                let identifier = "NewsNotification"
                
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                
                center.add(request, withCompletionHandler: nil)
                
                let controller = UIAlertController(title: nil, message: "\(dateComponents.hour!)時\(dateComponents.minute!)分に通知する設定を行いました", preferredStyle: UIAlertControllerStyle.alert)
                controller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(controller, animated:true ,completion: nil)
            }else{
                let controller = UIAlertController(title: nil, message: "通知の設定が許可されていません。設定アプリ方通知の設定をご確認ください", preferredStyle: UIAlertControllerStyle.alert)
                controller.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(controller, animated:true ,completion: nil)
            }
        })
    }
    
    
    
    @IBAction func onCloseButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
