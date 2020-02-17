//
//  SingleDevice.swift
//  Sheliaj
//
//  Created by Itay Brenner on 2/16/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Foundation

enum Status {
    case booted
    case shutdown
}

class SingleDevice: Device {
    private static let regexPattern: String = "^    (.+) \\((.+)\\) \\((.+)\\) $"

    let status: Status

    init(name: String, uuid: String, status: Status) {
        self.status = status
        super.init(name: name, uuid: uuid)
    }

    static func parseDevice(_ line: String) -> SingleDevice? {
        let regex = try? NSRegularExpression(pattern: SingleDevice.regexPattern, options: [])
        if let match = regex!.firstMatch(in: line,
                                         options: [],
                                         range: NSRange(line.startIndex..<line.endIndex, in: line)) {
            var name = ""
            var udid = ""
            var state = ""

            if let nameRange = Range(match.range(at: 1), in: line) {
                name = String(line[nameRange])
            }

            if let udidRange = Range(match.range(at: 2), in: line) {
                udid = String(line[udidRange])
            }

            if let stateRange = Range(match.range(at: 3), in: line) {
                state = String(line[stateRange])
            }

            return SingleDevice(name: name,
                          uuid: udid,
                          status: state == "Booted" ? .booted : .shutdown)
        }
        return nil
    }
}
