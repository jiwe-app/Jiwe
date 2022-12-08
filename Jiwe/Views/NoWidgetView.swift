//
//  NoWidgetView.swift
//  Jiwe
//
//  Created by Zaitam on 03/12/2022.
//

import SwiftUI

struct NoWidgetView: View {
    var body: some View {
        VStack {
            Text("Welcome to Jiwe!").font(Font.title).fontWidth(Font.Width(12)).fontWeight(Font.Weight.medium).padding(.bottom, 12)
            Text("Jiwe is a desktop customization tool which allows you to use widgets, just like this one, on top of your wall paper. To add a new widget open the widgets folder and add the files ending in '.dylib'. To create a new widget follow the guide on the repository's wiki. The widgets are programmed in swiftui to allow the app to be performant. Please take in notice this app is still in BETA version. Thanks for trying Jiwe!").frame(width: 300, alignment: .center).padding(.bottom, 12)
            HStack {
                Button(action: {
                    NSWorkspace.shared.selectFile(nil, inFileViewerRootedAtPath: widgetsDirectory().path)
                }) {
                    Text("Widget Dir").foregroundColor(Color.black).padding()
                }.background(RoundedRectangle(cornerRadius: 10, style: .continuous))
                Button(action: {
                    print("Nothing Here Yet")
                }) {
                    Text("Open Wiki").foregroundColor(Color.black).padding()
                }.background(RoundedRectangle(cornerRadius: 10, style: .continuous))
                Button(action: {
                    print("Nothing Here Yet")
                }) {
                    Text("Open Repo").foregroundColor(Color.black).padding()
                }.background(RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
        }.padding(12).background(Color.gray).cornerRadius(12)
    }
}

struct NoWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        NoWidgetView()
    }
}
