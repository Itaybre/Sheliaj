//
//  PayloadPusher.swift
//  Sheliaj
//
//  Created by Itay Brenner on 2/17/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Foundation
import Cocoa

struct PayloadPusher: PushSender {
    func sendPayload(_ payload: Payload,
                     device: Device,
                     bundleIdentifier: String) {
        do {
            let path = try buildPayload(payload)
            executeSendCommand(path,
                               device: device,
                               bundleIdentifier: bundleIdentifier)
        } catch {
            showAlert("Error", "Make sure the device selected is booted")
        }
    }

    func sendJSON(_ json: String,
                  device: Device,
                  bundleIdentifier: String) {
        let path = saveJSON(json)
        executeSendCommand(path,
                           device: device,
                           bundleIdentifier: bundleIdentifier)
    }

    private func buildPayload(_ payload: Payload) throws -> String {
        let jsonData = try JSONEncoder().encode(payload)
        return saveData(jsonData)
    }

    private func saveJSON(_ json: String) -> String {
        return saveData(json.data(using: .utf8)!)
    }

    private func saveData(_ data: Data) -> String {
        let url = Foundation.URL(fileURLWithPath: NSTemporaryDirectory(),
                                 isDirectory: true).appendingPathComponent("payload.json")
        FileManager.default.createFile(atPath: url.path,
                                       contents: data,
                                       attributes: nil)

        return url.path
    }

    private func executeSendCommand(_ path: String,
                                    device: Device,
                                    bundleIdentifier: String) {
        let command = "simctl push \(device.uuid) \(bundleIdentifier) \"\(path)\""
        let returnString = Process().shell(command)

        if returnString.contains("Notification sent to '\(bundleIdentifier)'") {
            showAlert("Success", "Push sent successfully")
        } else {
            showAlert("Error", "Make sure the device selected is booted")
        }
    }

    private func showAlert(_ text: String, _ informativeText: String) {
        let alert = NSAlert()
        alert.messageText = text
        alert.informativeText = informativeText
        alert.addButton(withTitle: "Ok")
        alert.runModal()
    }
}
