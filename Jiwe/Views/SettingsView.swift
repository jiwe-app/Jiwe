//
//  ContentView.swift
//  Jiwe
//
//  Created by Zaitam on 03/12/2022.
//

import SwiftUI
import ServiceManagement

// TODO:
// - Help links
// - Screen or screens (Each screen each widgets folder)

struct SettingsView: View {
    @State private var launchAtLogin = false //TODO: SMAppService.mainApp.status == .enabled (Currently for it to work on 12.0)
    @State private var widgetsDir = widgetsDirectory()
    @State private var pickerOption = ""
    @State private var allowInteraction = UserDefaults.standard.bool(forKey: "allowInteraction");
    
    func openFolderPicker () {
        let openPanel = NSOpenPanel()
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        openPanel.allowsMultipleSelection = false
        
        if openPanel.runModal() == .OK, let selectedFolderURL = openPanel.url {
            do {
                // Create a security-scoped bookmark that maintains read and write access
                let bookmark = try selectedFolderURL.bookmarkData(
                    options: [.withSecurityScope, .securityScopeAllowOnlyReadAccess],
                    includingResourceValuesForKeys: nil,
                    relativeTo: nil
                    //bookmarkDataIsStale: nil
                )
                UserDefaults.standard.set(bookmark, forKey: "widgetsFolderBookmark")
                pickerOption = ""
                widgetsDir = selectedFolderURL
                //TODO: Callback to reload widgets
            } catch {
                // Handle the error
            }

        }
    }
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Text("Startup:")
                
                Toggle(isOn: $launchAtLogin, label: { Text("Launch Jiwe at login") })
                    .onChange(of: launchAtLogin, perform: { newValue in
                    do {
                        if newValue {
                            if SMAppService.mainApp.status == .enabled {
                                try? SMAppService.mainApp.unregister()
                            }
                            try SMAppService.mainApp.register()
                        } else {
                            try SMAppService.mainApp.unregister()
                        }
                    } catch {
                        print("Failed to \(newValue ? "enable" : "disable") launch at login: \(error.localizedDescription)")
                    }
                })
            }
                HStack {
                    Picker(selection: $pickerOption, label: Text("Widgets folder:")) {
                        Text(widgetsDir.path).tag("")
                        // TODO: Add recently used directories
                        Divider()
                        Text("Other").tag("Other")
                    }.frame(width: 400).onChange(of: pickerOption) { val in
                        if val == "Other" {
                            openFolderPicker()
                        }
                    }
                }
            HStack {
                Text("Interactions:")
                Toggle(isOn: $allowInteraction, label: {Text("Allow user interaction with widgets")}).onChange(of: allowInteraction, perform: { newVal in
                        UserDefaults.standard.set(newVal, forKey: "allowInteraction")
                        //TODO: Callback to allow interaction
                })
            }
            
        } .padding(20.0).frame(width: 600, height: 400, alignment: .center)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
