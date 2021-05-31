//
//  DetailView.swift
//  Reddit Client
//
//  Created by Женя on 29.05.2021.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var detailVM: DetailViewModel
        
    var body: some View {
        WebView(urlString: detailVM.url)
            .toolbar(content: {
                if detailVM.saveButtonEnable {
                    Button(action: {
                        detailVM.savePhoto()
                    }, label: {
                        Label("Save", systemImage: "square.and.arrow.down")
                    })
                }
            })
            .alert(isPresented: $detailVM.imageWasSaved) {
                Alert(title: Text("Info"),
                      message: Text("The image was saved."),
                      dismissButton: .default(Text("Got it!")))
            }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(detailVM: DetailViewModel(url: "https://www.google.com"))
    }
}
