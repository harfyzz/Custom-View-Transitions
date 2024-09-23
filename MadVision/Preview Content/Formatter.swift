//
//  Utilities.swift
//  MadVision
//
//  Created by Afeez Yunus on 23/09/2024.
//

import Foundation

struct Formatter {
   static func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long // This gives you "April 20, 2024"
        dateFormatter.timeStyle = .none // No time information
        
        return dateFormatter.string(from: date)
    }
    
    static func timeFormatted( totalSeconds: Int) -> String {
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let remainingSeconds = totalSeconds % 60
        
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, remainingSeconds)
        } else {
            return String(format: "%02d:%02d min", minutes, remainingSeconds)
        }
    }
}
