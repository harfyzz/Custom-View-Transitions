//
//  ContentView.swift
//  MadVision
//
//  Created by Afeez Yunus on 23/09/2024.
//

import SwiftUI

struct MainView: View {
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
                            }
                            withAnimation(.timingCurve(0.82, 0.03, 0.17, 1.01, duration: 0.6)){
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
                            }
                            withAnimation(.timingCurve(0.82, 0.03, 0.17, 1.01, duration: 0.6)){
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
                        .transition(.reverseMove)
                } else {
                    CuriosityView()
                        .overlay {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.gray.opacity(isTransitioning ? 6 : 0))
                        }
                        .scaleEffect(isTransitioning || showOptions ? 0.9 : 1)
                        .transition(.move)
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
    
    func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            withAnimation{
                countdown -= 1
            }
        }
    }
}

#Preview {
    MainView()
}


struct MoveTransition: ViewModifier {
    var progress: CGFloat = 0
    func body(content: Content) -> some View {
        content
            .offset(x: progress * UIScreen.main.bounds.width, y: 0)
    }
}

extension AnyTransition {
    static let move: AnyTransition = .modifier(
        active: MoveTransition(progress: 1),
        identity: MoveTransition()
    )
    static let reverseMove: AnyTransition = .modifier(
        active: MoveTransition(progress: -1),
        identity: MoveTransition()
    )
    
}
