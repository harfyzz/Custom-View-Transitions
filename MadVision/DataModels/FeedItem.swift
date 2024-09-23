//
//  FeedItem.swift
//  MadVision
//
//  Created by Afeez Yunus on 23/09/2024.
//

import Foundation

struct FeedItem: Codable, Identifiable {
    var id: UUID = UUID()
    var creator: String = ""
    var creatoravatar: String = ""
    var title: String = ""
    var image:String = ""
    var isSaved: Bool = false
    var description: String = ""
    var publishedAt: Date = Date()
    var tags = [Tag] ()
}

struct Tag: Codable {
    var name: String  = ""
}
