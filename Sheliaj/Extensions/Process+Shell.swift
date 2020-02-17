//
//  Process+Shell.swift
//  Stolen from Poes(https://github.com/AvdLee/Poes)
//
//  Created by Antoine van der Lee on 10/01/2020.
//  Copyright © 2020 AvdLee. All rights reserved.
//

import Foundation

extension Process {
    func shell(_ command: String) -> String {
        launchPath = "/bin/bash"
        arguments = ["-c", command]

        let outputPipe = Pipe()
        standardOutput = outputPipe
        launch()

        let data = outputPipe.fileHandleForReading.readDataToEndOfFile()
        guard let outputData = String(data: data, encoding: String.Encoding.utf8) else { return "" }

        return outputData.reduce("") { (result, value) in
            return result + String(value)
        }.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
