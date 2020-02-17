//
//  ContentView.swift
//  Sheliaj
//
//  Created by Itay Brenner on 2/11/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import SwiftUI
import Resolver

protocol PusherView {
    mutating func devicesUpdated(devices: [Device])
}

struct PusherViewImp: View, PusherView {
    private var devices: [Device] = []
    @ObservedObject var pushModel: PushModel

    var presenter: PusherPresenter

    init(_ presenter: PusherPresenter) {
        self.presenter = presenter
        self._pushModel = ObservedObject(initialValue: presenter.pushModel())
        self.devices = presenter.deviceList()
    }

    func defaultPayload() -> Payload {
        return Payload(title: "Example Title",
                       body: "Example Body",
                       isMutable: false,
                       badge: 0)
    }

    func selectedDeviceName() -> String {
        return self.presenter.selectedDevice().name
    }

    mutating func devicesUpdated(devices: [Device]) {
        self.devices.append(contentsOf: devices)
    }

    var body: some View {
        VStack {
            Spacer()
                .frame(height: 10.0)
            HStack {
                MenuButton(label: Text(selectedDeviceName())) {
                    ForEach(devices, id: \.self) { device in
                        Button(action: {
                            self.presenter.deviceChanged(device)
                        }) {
                            Text(device.displayName())
                        }
                    }
                }
                Button(action: {
                    self.presenter.sendPressed()
                }) {
                    Text("Send")
                }
            }
                .frame(width: 650.0)

            Divider()

            GroupBox(label: EmptyView()) {
                if pushModel.isAdvanced {
                    AdvancedView(bundleIdentifier: $pushModel.bundleIdentidier,
                                 text: $pushModel.json)
                } else {
                    SimpleView(bundleIdentifier: $pushModel.bundleIdentidier,
                               mutableContent: $pushModel.isMutable,
                               pushTitle: $pushModel.title,
                               pushBody: $pushModel.body,
                               badgeValue: $pushModel.badge)
                }
            }

            HStack {
                Spacer()
                Toggle(isOn: $pushModel.isAdvanced) {
                    Text("Advanced Mode")
                }
            }
                .frame(width: 675.0)

            Spacer()
                .frame(height: 10.0)
        }
            .frame(width: 700.0)
    }
}

#if DEBUG
// swiftlint:disable type_name
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PusherViewImp(PusherPresenter_Previews())
    }
}

struct PusherPresenter_Previews: PusherPresenter {
    func deviceList() -> [Device] {
        return []
    }

    func selectedDevice() -> Device {
        return AllDevices.allDevices
    }

    func pushModel() -> PushModel {
        return PushModel()
    }

    func setView(_ view: PusherView) {
        print("set view")
    }

    func sendPressed() {
        print("Send pressed")
    }

    func deviceChanged(_ device: Device) {
        print("Device changed")
    }
}
// swiftlint:enable type_name
#endif
