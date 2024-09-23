//
//  ContentView.swift
//  MadVision
//
//  Created by Afeez Yunus on 23/09/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var showViewTwo = false
    @State private var pageTitle = "Curiosity"
    @State private var countdown = 1800
    @State var feedItem: [FeedItem] = []
    @State var scaling: Double = 1.0
    var body: some View {
        VStack(spacing:16){
            HStack{
                HStack{
                    Text(pageTitle)
                        .font(.title3)
                    Image(systemName: "chevron.down")
                }
                .fontWeight(.semibold)
                Spacer()
                Text(Formatter.timeFormatted(totalSeconds: countdown))
                    .onAppear() {
                        startCountdown()
                    }
                
                    .foregroundStyle(.gray)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                
            }
            if showViewTwo {
                ViewTwo()
                    .scaleEffect(scaling)
                    .transition(.move(edge: .leading))
            } else {
                ViewOne()
                    .scaleEffect(scaling)
                    .transition(.move(edge: .trailing))
            }
            Text(showViewTwo ? "Click here to go to View One" :"Click here to go to View Two")
                .onTapGesture {
                    withAnimation {
                        scaling = 0.8
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation {
                            showViewTwo.toggle()
                        }
                        
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        withAnimation {
                            scaling = 1.0
                        }
                    }
                }
        }
        .padding(.horizontal, 16)
        
    }
    func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            countdown -= 1
        }
    }
    
    
}

#Preview {
    ContentView()
}

struct ViewOne: View {
    @State var feedItem = FeedItem()
    var dataservice = DataService()
    var body: some View {
        FeedComponent(feedItem: feedItem)
        .onAppear{
            dataservice.loadFeedItems()
        }
    }
}

struct ViewTwo: View {
    @State var feedItem: FeedItem?
    var body: some View {
        VStack{
            
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.black.gradient)
        }
    }
}
