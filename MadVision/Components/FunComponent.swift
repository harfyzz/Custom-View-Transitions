//
//  FeedComponent.swift
//  MadVision
//
//  Created by Afeez Yunus on 23/09/2024.
//

import SwiftUI

struct FunComponent: View {
    var feedItem = FeedItem()
    let deviceWidth = UIScreen.main.bounds.width
    var body: some View {
        
        VStack(spacing:12){
            HStack {
                HStack{
                    Image(feedItem.creatoravatar)
                        .resizable()
                        .frame(width:48, height: 48)
                        .clipShape(Circle())
                    Text(feedItem.creator)
                        .font(.title3)
                }
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.bottom, 8)
            ZStack(alignment:.bottomLeading){
                Image(feedItem.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: deviceWidth - 32, height: 600)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                VStack(alignment:.leading, spacing: 8){
                    Image(systemName: "bookmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16)
                        .padding(.bottom, 4)
                    Text(Formatter.formatDate(feedItem.publishedAt))
                        .font(.subheadline)
                    Text(feedItem.title)
                        .font(.title3.bold())
                    HStack{
                        ForEach(feedItem.tags, id: \.name ) { tag in
                            TagItem(tagText:tag.name)
                        }
                    }
                    
                    Text(feedItem.description)
                        .font(.body)
                        .foregroundStyle(Color(.white))
                        .font(.title)
                }
                .padding(12)
                .foregroundStyle(.white)
                .shadow(color: .black.opacity(0.6), radius: 4, x: 1, y: 1)
                
            }
        }
        .padding(.bottom, 48)
        
    }
}


#Preview {
    MainView()
}


