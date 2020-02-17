//
//  AppDelegate.swift
//  Sheliaj
//
//  Created by Itay Brenner on 2/11/20.
//  Copyright © 2020 Itay Brenner. All rights reserved.
//

import Cocoa
import SwiftUI
import Resolver

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let presenter = PusherPresenterImp()
        let contentView = PusherViewImp(presenter)

        // Create the window and set the content view. 
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { DevicesParser() }
            .implements(Parser.self)

        register { DevicesProvider() }
            .implements(Provider.self)

        register { PayloadPusher() }
            .implements(PushSender.self)
    }
}
