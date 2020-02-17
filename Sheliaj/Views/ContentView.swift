//
//  ContentView.swift
//  Sheliaj
//
//  Created by Itay Brenner on 2/11/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import SwiftUI

struct PusherView: View {
    let provider: Provider
    let pusher: Pusher

    @State var devices: [Device]
    @State private var selectedDevice: Device
    @ObservedObject var pushModel: PushModel

    init(_ provider: Provider, _ pusher: Pusher) {
        self.pusher = pusher
        self.provider = provider
        self._devices = State(initialValue: provider.getDevices())
        self._selectedDevice = State(initialValue: self.provider.allDevices())
        self._pushModel = ObservedObject(initialValue: PushModel())
    }

    func defaultPayload() -> Payload {
        return Payload(title: "Example Title",
                       body: "Example Body",
                       isMutable: false,
                       badge: 0)
    }

    func selectedDeviceName() -> String {
        return self.selectedDevice.name
    }

    var body: some View {
        VStack {
            Spacer()
                .frame(height: 10.0)
            HStack {
                MenuButton(label: Text(selectedDeviceName())) {
                    ForEach(devices, id: \.self) { device in
                        Button(action: {
                            self.selectedDevice = device
                        }) {
                            Text(device.displayName())
                        }
                    }
                }
                Button(action: {
//                    self.pusher.sendPayload(self.payload,
//                                            device: self.selectedDevice,
//                                            bundleIdentifier: self.bundleIdentifier)
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
        PusherView(Provider_Previews(), Pusher_Previews())
    }
}

struct Provider_Previews: Provider {
    func getDevices() -> [Device] {
        return []
    }

    func allDevices() -> Device {
        return Device(name: "All Devices", uuid: "")
    }
}

struct Pusher_Previews: Pusher {
    func sendJSON(_ json: String, device: Device, bundleIdentifier: String) {
        print("send json")
    }

    func sendPayload(_ payload: Payload, device: Device, bundleIdentifier: String) {
        print("Sent pressed")
    }
}
// swiftlint:enable type_name
#endif
