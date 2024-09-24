//
//  ContentView.swift
//  MadVision
//
//  Created by Afeez Yunus on 23/09/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var isFunMode = false
    @State private var pageTitle = "Curious mode"
    @State private var countdown = 1800
    @State var feedItem: [FeedItem] = []
    @State var showOptions = false
    @State var isTransitioning = false
    var body: some View {
        VStack(spacing:16){
            VStack(alignment: .leading) {
                HStack{
                    HStack{
                        Text(pageTitle)
                            .font(.title3)
                            .contentTransition(.numericText())
                        Image(systemName: showOptions ? "chevron.up" : "chevron.down")
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
                                .stroke(Color("text.tertiary").opacity(0.5))
                        }
                    
                }.background()
                .onTapGesture {
                    withAnimation(.spring(duration: 0.3)) {
                        showOptions.toggle()
                    }
                }
                .padding(.bottom, showOptions ? 16 : 0)
                if showOptions {
                    HStack {
                        Image(systemName: "brain")
                            .aspectRatio(contentMode: .fit)
                            .frame(width:32, height:32)
                        VStack(alignment: .leading, spacing: 4){
                            Text("Curious mode")
                                .fontWeight(.semibold)
                            Text("learning + 10% fun")
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        if isFunMode == false {
                            Image(systemName: "checkmark.circle.fill")
                                .aspectRatio(contentMode: .fit)
                                .frame(width:32, height:32)
                        }
                    }.background()
                        .onTapGesture {
                            withAnimation {
                                showOptions = false
                                isFunMode = false
                                pageTitle = "Curious mode"
                            }
                            }
                    HStack {
                        Image(systemName: "lasso.badge.sparkles")
                            .aspectRatio(contentMode: .fit)
                            .frame(width:32, height:32)
                        VStack(alignment: .leading, spacing: 4){
                            Text("Fun mode")
                                .fontWeight(.semibold)
                            Text("90% fun and a little learning")
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        if isFunMode {
                            Image(systemName: "checkmark.circle.fill")
                                .aspectRatio(contentMode: .fit)
                                .frame(width:32, height:32)
                        }
                        
                    }.background()
                        .onTapGesture {
                            withAnimation {
                                showOptions = false
                                isFunMode = true
                                pageTitle = "Fun mode"
                            }
                            }
                }
                
            }.padding(.bottom, showOptions ? 8 : 0)
                
            
            ZStack{
                if isFunMode {
                    FunView()
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.gray.opacity(isTransitioning ? 6 : 0))
                        }
                        .scaleEffect(isTransitioning || showOptions ? 0.9 : 1)
                        .transition(.reverseFlip)
                } else {
                    CuriosityView()
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.gray.opacity(isTransitioning ? 6 : 0))
                        }
                        .scaleEffect(isTransitioning || showOptions ? 0.9 : 1)
                        .transition(.flip)
                }
            }
            .onTapGesture {
                withAnimation{
                    showOptions = false
                }
            }
            .onScrollPhaseChange { phase,_  in
                if phase == .interacting {
                    withAnimation {
                        showOptions = false
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
        }
        .ignoresSafeArea()
        .background()
        .padding(.top, 4)
        .padding(.horizontal, 16)
        
    }
    
    var customTransition: AnyTransition {
        let insertion = AnyTransition.move(edge: isFunMode ? .trailing : .leading)
            .combined(with: .scale(scale: 1.0))
            .animation(.easeInOut)
        let removal = AnyTransition.move(edge: isFunMode ? .leading : .trailing)
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
            .offset(x: progress * UIScreen.main.bounds.width, y: 0)
        
        
        
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
