//
//  JsonParser.swift
//  MadVision
//
//  Created by Afeez Yunus on 23/09/2024.
//

import Foundation

struct DataService {
    let dateFormatter = ISO8601DateFormatter()
    
    // Function to load and decode the Feed.json file
    func loadFeedItems() -> [FeedItem]? {
        guard let url = Bundle.main.url(forResource: "Feed", withExtension: "json") else {
            print("Failed to locate Feed.json in bundle.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
            
            // Set the date decoding strategy to ISO 8601
            decoder.dateDecodingStrategy = .iso8601
            
            let feedItems = try decoder.decode([FeedItem].self, from: data)
            
            return feedItems
        } catch {
            print("Failed to decode Feed.json: \(error)")
            return nil
        }
    }
    
}
