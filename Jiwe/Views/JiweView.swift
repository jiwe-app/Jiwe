//
//  JiweView.swift
//  Jiwe
//
//  Created by Zaitam on 03/12/2022.
//

import SwiftUI

struct JiweView: View {
    var body: some View {
        ZStack {
            if (allWidgetsInDirectory().isEmpty) {
                NoWidgetView()
            } else {
                ForEach(allWidgetsInDirectory(), id: \.self) { w in
                    AnyView(LoadPlugin(at: "\(widgetsDirectory().path)/\(w)").view)
                }
            }
        }
        .frame(minWidth: 1000, maxWidth: .infinity, minHeight: 800, maxHeight: .infinity)
    }
}
