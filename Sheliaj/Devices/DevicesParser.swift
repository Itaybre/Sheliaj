//
//  DevicesParser.swift
//  Sheliaj
//
//  Created by Itay Brenner on 2/16/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Foundation

protocol Parser {
    func parseString(_ string: String) -> [Device]
}

struct DevicesParser: Parser {
    func parseString(_ string: String) -> [Device] {
        let lines = string.split(separator: "\n")

        var reachedDevices = false
        var devices: [Device] = []

        for line in lines {
            switch line {
            case "== Device Types ==":
                reachedDevices = false
                continue
            case "== Runtimes ==":
                reachedDevices = false
                continue
            case "== Devices ==":
                reachedDevices = true
                continue
            case "== Device Pairs ==":
                reachedDevices = false
                continue
            default:
                if reachedDevices,
                    let device = SingleDevice.parseDevice(String(line)) {
                    devices.append(device)
                }
            }
        }

        return devices
    }
}
