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
                    .contentTransition(.numericText())
                    .onAppear() {
                        startCountdown()
                    }
                
                    .foregroundStyle(.gray)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .overlay {
                        RoundedRectangle(cornerRadius: 64)
                            .stroke(Color("text.tertiary").opacity(0.3))
                    }
                
            }
            ZStack{
                if showViewTwo {
                    FunView()
                        .scaleEffect(scaling)
                        .transition(customTransition)
                } else {
                    CuriosityView()
                        .scaleEffect(scaling)
                        .transition(customTransition)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
            Text(showViewTwo ? "Click here to go to View One" :"Click here to go to View Two")
                .onTapGesture {
                    withAnimation {
                        scaling = 0.7
                            
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation {
                            showViewTwo.toggle()
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        withAnimation {
                            scaling = 1
                        }
                    }
                    
                }
        }
        .preferredColorScheme(.dark)
        .background()
        .padding(.horizontal, 16)
        
    }
    
    var customTransition: AnyTransition {
        let insertion = AnyTransition.move(edge: showViewTwo ? .trailing : .leading)
                .combined(with: .scale(scale: 1.0))
                .animation(.easeInOut)
        let removal = AnyTransition.move(edge: showViewTwo ? .leading : .trailing)
                .combined(with: .scale(scale: 0.7))
                .animation(.easeInOut)
            
            return .asymmetric(insertion: insertion, removal: removal)
        }
   
    
    func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            withAnimation{
                countdown -= 1
            }
        }
    }
    
    
}

#Preview {
    ContentView()
}


struct FlipTransition: ViewModifier {
    var progress: CGFloat = 0
    func body(content: Content) -> some View {
        content
            .rotation3DEffect(.degrees(progress * 180), axis: (x: 0, y: 1, z: 0))
            
            
    }
}

extension AnyTransition {
    static let flip: AnyTransition = .modifier(
        active: FlipTransition(progress: 1),
        identity: FlipTransition()
    )
    static let reverseFlip: AnyTransition = .modifier(
        active: FlipTransition(progress: -1),
        identity: FlipTransition()
    )
    
}
