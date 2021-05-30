//
//  ContentView.swift
//  Reddit Client
//
//  Created by Женя on 24.05.2021.
//

import SwiftUI
import CoreData


import SwiftUI

struct ContentView: View {
    @ObservedObject var postListViewModel: PostListViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(postListViewModel.postsVM) { post in
                    NavigationLink(destination: DetailView(url: post.url, saveButtonEnable: post.isSavingEnable)) {
                        PostCell(postVM: post)
                    }
                }
                if postListViewModel.fetchingAllowed {
                    Text("Fetching posts...")
                        .onAppear(perform: fetchList)
                }
            }
            .navigationBarTitle("Reddit")
        }
    }
    
    private func fetchList() {
        postListViewModel.fetchList()
    }
}

struct PostsList_Previews : PreviewProvider {
    static var previews: some View {
        ContentView(postListViewModel: PostListViewModel(manager: NetworkManager()))
    }
}
