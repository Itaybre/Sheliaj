//
//  PusherPresenter.swift
//  Sheliaj
//
//  Created by Itay Brenner on 2/17/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Foundation

protocol PusherPresenter {
    func sendPressed()
    func deviceChanged(_ device: Device)
    func selectedDevice() -> Device
    func pushModel() -> PushModel
    func deviceList() -> [Device]
}
