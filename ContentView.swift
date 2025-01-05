//
//  ContentView.swift
//  FastingMate
//
//  Created by Akshara Unnikrishnan on 04/01/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var fastingManager = FastingManager()
    
    var body: some View {
        ZStack {
            Color(uiColor: .black)
                .ignoresSafeArea()
            content
        }
    }
    
    var content: some View {
        ZStack {
            titleView
            VStack( spacing: 40) {
                // Progress Ring
                Spacer().frame(height: 40)
                FastingProgress().environmentObject(fastingManager)
                timeView
                buttonView
            }
            .padding()
        }
        
        .foregroundColor(.white)
    }
    
    var titleView: some View {
        VStack(spacing: 40) {
            Text("Fasting Progress")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(fastingManager.fastingPlan.rawValue)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(.ultraThinMaterial)
                    .cornerRadius(8)
            Spacer()
        }.padding()
        
    }
    
    var timeView: some View {
        HStack(spacing: 40) {
            VStack( spacing: 20) {
                Text(fastingManager.fastingState == .notStarted ? "Start" : "Started")
                    .opacity(0.7)
                
                Text(Date(), format: .dateTime.weekday().hour().minute())
                    .fontWeight(.bold)
        
            }
            VStack( spacing: 20) {
                Text(fastingManager.fastingState == .notStarted ? "End" : "Ends")
                    .opacity(0.7)
                
                Text(Date().addingTimeInterval(16), format: .dateTime.weekday().hour().minute())
                    .fontWeight(.bold)
        
            }
        }
    }
    
    var buttonView: some View {
        VStack {
            Button {
                fastingManager.toggleFastingState()
            } label : {
                Text(fastingManager.fastingState == .fasting ? "End fasting" : "Start Fasting")
                        .fontWeight(.semibold)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(.ultraThinMaterial)
                        .cornerRadius(8)
            }
        }
    }
}

#Preview {
    ContentView()
}
