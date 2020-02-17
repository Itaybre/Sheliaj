//
//  PusherPresenterImp.swift
//  Sheliaj
//
//  Created by Itay Brenner on 2/17/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Foundation
import Resolver

class PusherPresenterImp: PusherPresenter {
    @Injected var pusher: PushSender
    @Injected var provider: Provider

    private let model: PushModel
    private var device: Device

    init() {
        self.model = PushModel()
        self.device = AllDevices.allDevices
    }

    func sendPressed() {
        if model.isAdvanced {
            pusher.sendPayload(model.toPayload(),
                               device: device,
                               bundleIdentifier: model.bundleIdentidier)
        } else {
            pusher.sendJSON(model.json,
                            device: device,
                            bundleIdentifier: model.bundleIdentidier)
        }
    }

    func deviceChanged(_ device: Device) {
        self.device = device
    }

    func selectedDevice() -> Device {
        return device
    }

    func pushModel() -> PushModel {
        return model
    }

    func deviceList() -> [Device] {
        return provider.getDevices()
    }
}
