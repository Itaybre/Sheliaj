//
//  DevicesProvider.swift
//  Sheliaj
//
//  Created by Itay Brenner on 2/16/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Foundation
import Resolver

protocol Provider {
    func allDevices() -> Device
    func getDevices() -> [Device]
}

class DevicesProvider: Provider {
    @Injected var deviceParser: Parser

    private var devices: [Device] = []

    init() {
        updateList()
    }

    func updateList() {
        devices = []
        devices.append(AllDevices.allDevices)

        let output = executeShell()
        devices.append(contentsOf: deviceParser.parseString(output))
    }

    func getDevices() -> [Device] {
        return devices
    }

    func allDevices() -> Device {
        return AllDevices.allDevices
    }

    func executeShell() -> String {
        return Process().shell("xcrun simctl list")
    }
}
