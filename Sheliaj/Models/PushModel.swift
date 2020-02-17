//
//  PushModel.swift
//  Sheliaj
//
//  Created by Itay Brenner on 2/17/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Foundation

class PushModel: ObservableObject {
    @Published var bundleIdentidier: String = "com.apple.Maps"
    @Published var isMutable: Bool = false
    @Published var title: String = "Example Title"
    @Published var body: String = "Example Body"
    @Published var badge: Int = 0

    @Published var isAdvanced: Bool = false
    @Published var json: String = """
    {
        "aps" : {
            "alert" : {
                "title" : "Default title",
                "body" : "Default body"
            },
            "mutable-content" : false
        }
    }
    """

    func toPayload() -> Payload {
        return Payload(title: title,
                       body: body,
                       isMutable: isMutable,
                       badge: badge)
    }
}
