//
//  AllDevices.swift
//  Sheliaj
//
//  Created by Itay Brenner on 2/16/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Foundation

class AllDevices: Device {

    public static var allDevices = AllDevices(name: "All Simulators", uuid: "")

    private override init(name: String, uuid: String) {
        super.init(name: name, uuid: "booted")
    }

    public override func displayName() -> String {
        return "\(name)"
    }
}
