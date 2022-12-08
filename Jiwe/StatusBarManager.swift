//
//  statusBarItem.swift
//  Jiwe
//
//  Created by Zaitam on 05/12/2022.
//

import Foundation
import SwiftUI

class StatusBarManager {
    let statusBarItem: NSStatusItem;
    
    init () {
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength);
        statusBarItem.button?.image = NSImage(systemSymbolName: "lasso.and.sparkles", accessibilityDescription: "")
        let menu = NSMenu()
        //menu.addItem(withTitle: "About", action: #selector(AppDelegate.OpenAboutWindow), keyEquivalent: "")
        menu.addItem(withTitle: "Reload", action: #selector(AppDelegate.objcReloadWidgets), keyEquivalent: "")
        menu.addItem(withTitle: "Settings", action: #selector(AppDelegate.OpenSettingsWindow), keyEquivalent: "")
        menu.addItem(NSMenuItem.separator())
        menu.addItem(withTitle: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "")
        
        statusBarItem.menu = menu
    }

}
