//
//  TagItem.swift
//  MadVision
//
//  Created by Afeez Yunus on 23/09/2024.
//

import SwiftUI

struct TagItem: View {
    @State var tagText = "Hello, World!"
    var body: some View {
    
        Text(tagText)
            .tagComponent()
    }
}

#Preview {
    TagItem()
}
