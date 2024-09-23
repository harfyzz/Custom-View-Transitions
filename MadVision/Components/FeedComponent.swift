//
//  FeedComponent.swift
//  MadVision
//
//  Created by Afeez Yunus on 23/09/2024.
//

import SwiftUI

struct FeedComponent: View {
    @State var feedItem = FeedItem()
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment:.leading){
                HStack {
                    HStack{
                        Image("avatar2")
                            .resizable()
                            .frame(width:48, height: 48)
                            .clipShape(Circle())
                        Text("Sharon Smith")
                            .font(.title3)
                    }
                    Spacer()
                    Image(systemName: "ellipsis")
                }
                .padding(.bottom, 8)
                
                Image("image1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width:(proxy.size.width) - 32, height: 400)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.bottom, 16)
                HStack{
                    VStack(alignment:.leading, spacing: 8){
                        Text(Formatter.formatDate(feedItem.publishedAt))
                            .font(.headline)
                            .foregroundStyle(.white.opacity(0.5))
                        Text("The Future of Software Development")
                            .font(.title2)
                            
                    }.padding(.trailing, 24)
                    Spacer()
                    Image(systemName: "bookmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                }
                .font(.title)
                HStack{
                    /*
                     ForEach(feedItem.tags, id: \.name ) { tag in
                     TagItem(tagText:tag.name)
                     
                     }
                     */
                    TagItem(tagText:"SwiftUI")
                    TagItem(tagText:"Software")
                    TagItem(tagText:"Ai/ml")
                }
                Text("This article discusses emerging trends in software development, focusing on methodologies that enhance productivity and creativity in coding practices.")
                    .font(.body)
                    .foregroundStyle(.white.opacity(0.75))
            }
            .padding(.horizontal)
            
        }
    }
}

#Preview {
    FeedComponent()
}
