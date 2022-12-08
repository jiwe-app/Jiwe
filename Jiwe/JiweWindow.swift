//
//  Window.swift
//  Jiwe
//
//  Created by Zaitam on 03/12/2022.
//

import SwiftUI

class JiweWindow: NSWindow {
    convenience init() {
        self.init(
            contentRect: .zero,
            styleMask: [
                .borderless
            ],
            backing: .buffered,
            defer: false
        )
        
        // Window config
        self.title = "Widget-app"
        self.titleVisibility = .hidden
        self.titlebarAppearsTransparent = true
        self.isOpaque = false
        self.isRestorable = false
        self.canHide = false
        self.displaysWhenScreenProfileChanges = true
        self.backgroundColor = .clear
        self.isReleasedWhenClosed = false
        self.standardWindowButton(.closeButton)?.isHidden = true
        self.standardWindowButton(.miniaturizeButton)?.isHidden = true
        self.standardWindowButton(.zoomButton)?.isHidden = true
        self.collectionBehavior = [
            .stationary,
            .ignoresCycle,
            .fullScreenNone,
            .canJoinAllSpaces
        ]
        
        self.contentView = NSHostingView(rootView: JiweView())
        self.level = NSWindow.Level(NSWindow.Level.normal.rawValue - 1)
        guard let screen = NSScreen.main else {
            return
        }
        setFrame(screen.visibleFrame, display: true)
        orderFront(nil)
    }
    func reloadWidgets() {
        self.contentView = NSHostingView(rootView: JiweView())
    }
}
