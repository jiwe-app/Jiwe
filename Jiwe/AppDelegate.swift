//
//  AppDelegate.swift
//  Jiwe
//
//  Created by Zaitam on 03/12/2022.
//

import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarManager: StatusBarManager?
    public var jiweWindow: JiweWindow?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.jiweWindow = JiweWindow()
        //NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
        self.statusBarManager = StatusBarManager()
    }
    
    public func reloadWidgets() {
        jiweWindow?.reloadWidgets()
    }
    
    @objc func objcReloadWidgets () {
        jiweWindow?.reloadWidgets()
    }
    
    @objc func OpenSettingsWindow() {
        NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
    }
}
