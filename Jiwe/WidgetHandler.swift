//
//  WidgetHandler.swift
//  Jiwe
//
//  Created by Zaitam on 03/12/2022.
//

import Foundation
import JiweInterface

typealias InitFunction = @convention(c) () -> UnsafeMutableRawPointer
func LoadPlugin(at path:String) -> JiweWidget {
    let openRes = dlopen(path, RTLD_NOW|RTLD_LOCAL)
        if openRes != nil {
            defer {
                dlclose(openRes)
            }

            let symbolName = "createPlugin"
            let sym = dlsym(openRes, symbolName)

            if sym != nil {
                let f: InitFunction = unsafeBitCast(sym, to: InitFunction.self)
                let pluginPointer = f()
                let builder = Unmanaged<JiweWidgetBuilder>.fromOpaque(pluginPointer).takeRetainedValue()
                return builder.build()
            }
            else {
                fatalError("error loading lib: symbol \(symbolName) not found, path: \(path)")
            }
        }
        else {
            if let err = dlerror() {
                fatalError("error opening lib: \(String(format: "%s", err)), path: \(path)")
            }
            else {
                fatalError("error opening lib: unknown error, path: \(path)")
            }
        }
}


func widgetsDirectory() -> URL { //TODO: Cleanup
    guard let bookmark = UserDefaults.standard.data(forKey: "widgetsFolderBookmark") else { return defaultDir() }
    do {
        var isStale = false
        let selectedFolderURL = try URL(resolvingBookmarkData: bookmark,
                                        options: .withSecurityScope,
                                        relativeTo: nil,
                                        bookmarkDataIsStale: &isStale)
        if selectedFolderURL.startAccessingSecurityScopedResource() {
            return selectedFolderURL
        }
        //let isReadable = FileManager.default.isReadableFile(atPath: selectedFolderURL.path)
        //let isWritable = FileManager.default.isWritableFile(atPath: selectedFolderURL.path)
        return defaultDir()
    } catch {
        return defaultDir()

    }
}

func defaultDir() -> URL {
    var url = FileManager().urls(for: .applicationSupportDirectory,
                                 in: .userDomainMask).first!
    url.appendPathComponent("widgets");
    if !FileManager().fileExists(atPath: url.path) {
        do {
            try FileManager().createDirectory(at: url, withIntermediateDirectories: false)
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    return url;
}

func allWidgetsInDirectory() -> [String] {
    var allWidgets: [String] = [];
    do {
        allWidgets = try FileManager.default.contentsOfDirectory(at: widgetsDirectory(), includingPropertiesForKeys: nil, options: []).filter({
                $0.path.hasSuffix(".dylib") && !$0.path.hasSuffix("libJiweInterface.dylib")
            // libJiweInterface will be the dependency dylib included, and it is not a widget so we exclude it
        }).map({ $0.lastPathComponent })
     }
     catch {
         print(error.localizedDescription)
     }
    return allWidgets;
}
