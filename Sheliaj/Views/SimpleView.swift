//
//  SimpleView.swift
//  Sheliaj
//
//  Created by Itay Brenner on 2/17/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import SwiftUI

struct SimpleView: View {
    @Binding var bundleIdentifier: String
    @Binding var mutableContent: Bool
    @Binding var pushTitle: String
    @Binding var pushBody: String
    @Binding var badgeValue: Int

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("Bundle Identifier")
                TextField("com.apple.Maps", text: $bundleIdentifier)
            }

            HStack(alignment: .center) {
                Text("Title")
                TextField("com.apple.Maps", text: $pushTitle)
            }

            HStack(alignment: .center) {
                Text("Body")
                TextField("Example Body", text: $pushBody)
            }

            HStack(alignment: .center) {
                Toggle(isOn: $mutableContent) {
                    Text("Mutable Content")
                }
            }

            Stepper(value: $badgeValue, in: 0...999) {
                Text("Badge number: \(badgeValue)")
            }
        }
        .frame(width: 650.0)
    }
}
