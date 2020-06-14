//
//  ContentView.swift
//  Biography
//
//  Created by Alfian Losari on 11/06/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

let screen = UIScreen.main

struct ContentView: View {
    
    @State var selectedPerson: Person?
    @State var bottomDragState: CGSize = .zero
    @State var showFull = false
    
    let people = Person.stubbed
    var heightBanner = (screen.bounds.height * 0.65)
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Ellipse().fill(Color(red: 78/255, green: 88/255, blue: 81/255))
                    .rotationEffect(.degrees(90))
                    .offset(y: -screen.bounds.width * 0.7)
                    .edgesIgnoringSafeArea(.top)
                    .opacity(self.selectedPerson == nil ? 1 : 0)
                
                VStack(alignment: .leading, spacing: 24) {
                    VStack(spacing: 20) {
                        Text("The Crazy Ones")
                            .font(.system(size: 36, weight: .medium))
                        Text("The misfits. The rebels. The troublemakers. The round pegs in the square holes. The ones who see things differently.")
                            .font(.system(size: 17))
                    }
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(self.people) { item in
                                GeometryReader { (proxy: GeometryProxy) in
                                    CardView(person: item)
                                        .rotation3DEffect(.degrees(Double(proxy.frame(in: .global).minX - 20) / -20), axis: (x: 0, y: 1, z: 0))
                                        .onTapGesture {
                                            withAnimation(Animation.spring()) {
                                                self.selectedPerson = item
                                            }
                                    }
                                }
                                .frame(width: screen.bounds.width * 0.75, height: screen.bounds.height * 0.65)
                            }
                        }
                        .padding(.horizontal, 32)
                        .padding(.vertical)
                    }
                }
                .blur(radius: self.selectedPerson == nil ? 0 : 50)
                
                ZStack {
                    Rectangle().fill(Color.clear)
                    if self.selectedPerson?.imageName != nil {
                        Image(self.selectedPerson!.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                .frame(width: screen.bounds.width)
                .frame(height: self.selectedPerson == nil ? nil : self.heightBanner)
                .offset(y: self.selectedPerson == nil ? -screen.bounds.height : (self.heightBanner / 2) - (screen.bounds.height / 2))
                .opacity(self.selectedPerson == nil ? 0.5 : 1)
                .blur(radius: self.bottomDragState.height > 0 ? min(self.bottomDragState.height, 50) : 0)
                .animation(.easeInOut)
                
                BottomTray(selectedPerson: self.selectedPerson, isScrollDisabled: !self.showFull)
                    .frame(maxWidth: .infinity)
                    .frame(height: screen.bounds.height * 0.7)
                    .padding(.top)
                    .padding(.bottom, 32)
                    .background(Color.white)
                    .cornerRadius(30)
                    .shadow(radius: 24)
                    .offset(y: self.selectedPerson == nil ? screen.bounds.height : screen.bounds.height * 0.5)
                    .offset(y: self.bottomDragState.height)
                    .gesture(DragGesture().onChanged({ (value) in
                        self.bottomDragState = value.translation
                        
                        if self.showFull {
                            self.bottomDragState.height += -300
                        }
                        
                        if self.bottomDragState.height < -300 {
                            self.bottomDragState.height = -300
                        }
                        
                    }).onEnded({ (value) in
                        withAnimation(Animation.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0)) {
                            if self.bottomDragState.height > 100 {
                                self.selectedPerson = nil
                                self.bottomDragState = .zero
                            }
                            
                            if self.bottomDragState.height < -200 || self.bottomDragState.height < -100 {
                                self.bottomDragState.height = -300
                                self.showFull = true
                            } else {
                                self.bottomDragState = .zero
                                self.showFull = false
                            }
                        }
                    }))
            }
        }
        .background(Color(red: 235/255, green: 235/255, blue: 227/255))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.top)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class HostingController: UIHostingController<ContentView> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
