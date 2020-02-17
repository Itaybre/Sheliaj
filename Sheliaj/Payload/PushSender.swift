//
//  Pusher.swift
//  Sheliaj
//
//  Created by Itay Brenner on 2/17/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Foundation

protocol PushSender {
    func sendPayload(_ payload: Payload, device: Device, bundleIdentifier: String)
    func sendJSON(_ json: String, device: Device, bundleIdentifier: String)
}
