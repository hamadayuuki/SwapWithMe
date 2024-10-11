//
//  NotificationService.swift
//  NotificationService
//
//  Created by 濵田　悠樹 on 2024/10/12.
//

import UserNotifications

// 画像を表示するPush通知をクライアント側で受け取れるように実装
// https://oishi-kenko.hatenablog.com/entry/2022/02/16/174327
class NotificationService: UNNotificationServiceExtension {
    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        guard let content = (request.content.mutableCopy() as? UNMutableNotificationContent) else {
            contentHandler(request.content)
            return
        }

        let userInfo = request.content.userInfo as NSDictionary
        let fcmOptions = userInfo["fcm_options"] as? [String: String]

        guard let fcmOptions = fcmOptions,
            let url = URL(string: fcmOptions["image"] ?? "")
        else {
            contentHandler(content)
            return
        }

        let task = URLSession.shared.dataTask(
            with: url,
            completionHandler: { data, _, error in
                let fileName = url.lastPathComponent
                let writePath = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)

                do {
                    try data?.write(to: writePath)
                    let attachment = try UNNotificationAttachment(identifier: fileName, url: writePath, options: nil)
                    content.attachments = [attachment]
                    contentHandler(content)
                } catch {
                    print("error: \(error)")
                    contentHandler(content)
                }
            })
        task.resume()
    }

    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent = bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
}

