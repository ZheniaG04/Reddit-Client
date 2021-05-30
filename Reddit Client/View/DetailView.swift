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
    
    @State private var showingAlert = false
    
    var body: some View {
        WebView(urlString: url)
            .toolbar(content: {
                if saveButtonEnable {
                    Button(action: {
                        let imageSaver = ImageSaver()
                        imageSaver.savePhoto(from: url)
                        showingAlert = true
                    }, label: {
                        Label("Save", systemImage: "square.and.arrow.down")
                    })
                }
            })
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Info"),
                      message: Text("The image was saved."),
                      dismissButton: .default(Text("Got it!")))
            }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(url: "https://www.google.com", saveButtonEnable: false)
    }
}
