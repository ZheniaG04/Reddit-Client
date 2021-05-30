//
//  PostCellView.swift
//  Reddit Client
//
//  Created by Женя on 25.05.2021.
//

import SwiftUI

struct PostCell: View {
    let postVM: PostViewModel
    
    var body: some View {
        HStack {
            Image(uiImage: postVM.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .cornerRadius(15)

            VStack(alignment: .leading, spacing: 5) {
                Text(postVM.title)
                    .font(.headline)
                    .lineLimit(2)
                    .minimumScaleFactor(0.5)
                
                Text(postVM.author)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                HStack(spacing: 5) {
                    Text(postVM.comments)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    
                    Image("comments")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10, height: 10)
                }
                
                Text(postVM.creationTime)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .onAppear {
            postVM.savePostLocally()
        }
    }
}

struct PostCell_Previews : PreviewProvider {
    static var previews: some View {
        PostCell(postVM: PostViewModel(post: Post(id: "", name: "", title: "new post new post ", author: "author name", url: "", thumbnail: "", postHint: "", comments: 100, createdUTC: 1622233742.0, image: UIImage(named: "no-image"))))
            .previewLayout(.sizeThatFits)
    }
}
