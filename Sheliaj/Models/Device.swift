//
//  Device.swift
//  Sheliaj
//
//  Created by Itay Brenner on 2/16/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Foundation

class Device {
    let name: String
    let uuid: String

    init(name: String, uuid: String) {
        self.name = name
        self.uuid = uuid
    }

    public func displayName() -> String {
        return "\(name) (\(uuid))"
    }
}

extension Device: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(uuid)
    }

    static func == (lhs: Device, rhs: Device) -> Bool {
        return lhs.uuid == rhs.uuid
    }

    static func < (lhs: Device, rhs: Device) -> Bool {
        return lhs.uuid < rhs.uuid
    }
}
