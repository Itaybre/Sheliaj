//
//  AdvancedView.swift
//  Sheliaj
//
//  Created by Itay Brenner on 2/17/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import SwiftUI

struct AdvancedView: View {
    @Binding var bundleIdentifier: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("Bundle Identifier")
                TextField("com.apple.Maps", text: $bundleIdentifier)
            }

            MacEditorTextView(text: $text)
                .environment(\.colorScheme, .light)
        }
        .frame(width: 650, height: 300)
    }
}
