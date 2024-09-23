//
//  FeedComponent.swift
//  MadVision
//
//  Created by Afeez Yunus on 23/09/2024.
//

import SwiftUI

struct FeedComponent: View {
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
                
                Image(feedItem.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: deviceWidth - 32, height: 400)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.bottom, 4)
                HStack(alignment:.top){
                    VStack(alignment:.leading, spacing: 8){
                        Text(Formatter.formatDate(feedItem.publishedAt))
                            .font(.subheadline.bold())
                            .foregroundStyle(Color("text.tertiary"))
                        Text(feedItem.title)
                            .font(.title3.bold())
                        HStack{
                            
                             ForEach(feedItem.tags, id: \.name ) { tag in
                             TagItem(tagText:tag.name)
                             
                             }
                             
                        }
                    }.padding(.trailing, 24)
                        .padding(.bottom, 8)
                    Spacer()
                    Image(systemName: "bookmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16)
                }
               
                Text(feedItem.description)
                    .font(.body)
                    .foregroundStyle(Color("text.secondary"))
                .font(.title)
            }
            .padding(.bottom, 48)
            
        }
    }


#Preview {
    CuriosityView()
}
