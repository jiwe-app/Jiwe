//
//  JiweApp.swift
//  Jiwe
//
//  Created by Zaitam on 03/12/2022.
//

import SwiftUI

@main
struct jiweApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    var body: some Scene {
        Settings {
            SettingsView()
        }
    }
}
