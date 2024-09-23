//
//  ViewModifiers.swift
//  MadVision
//
//  Created by Afeez Yunus on 23/09/2024.
//

import Foundation
import SwiftUI


extension View {
    func tagComponent() -> some View {
        self
            .padding(8)
            .background(.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .font(.caption.bold())
    }
    
}
