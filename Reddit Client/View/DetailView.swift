//
//  DetailView.swift
//  Reddit Client
//
//  Created by Женя on 29.05.2021.
//

import SwiftUI

struct DetailView: View {
    
    let url: String?
    let saveButtonEnable: Bool
    
    var body: some View {
        WebView(urlString: url)
            .toolbar(content: {
                if saveButtonEnable {
                    Button(action: {
                        let imageSaver = ImageSaver()
                        imageSaver.savePhoto(from: url)
                    }, label: {
                        Label("Save", systemImage: "square.and.arrow.down")
                    })
                }
            })
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://www.google.com", saveButtonEnable: false)
    }
}
