//
//  FastingProgress.swift
//  FastingMate
//
//  Created by Akshara Unnikrishnan on 04/01/25.
//

import SwiftUI

struct FastingProgress: View {
    @EnvironmentObject var fastingManager: FastingManager
    let timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
        
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .foregroundColor(.green)
                .opacity(0.2)
                
            
            Circle()
                .trim(from: 0.0, to: min(fastingManager.progress, 1.0))
                .stroke(AngularGradient(colors: [ .yellow, .blue, .purple, .brown, .green], center: .center), style: StrokeStyle(lineWidth: 15, lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut, value: fastingManager.progress)
            
            VStack(spacing: 30) {
                if fastingManager.fastingState == .notStarted {
                    VStack(spacing: 5) {
                        Text("Upcoming fast")
                            .opacity(0.7)
                        Text("\(fastingManager.fastingPlan.fastingPeriod.formatted()) Hours")
                            .font(.title)
                            .fontWeight(.bold)
                    }.padding(.top)
                } else {
                    VStack(spacing: 5) {
                        Text("Elapsed Time")
                            .opacity(0.7)
                        Text(fastingManager.startTime, style: .timer)
                            .font(.title)
                            .fontWeight(.bold)
                    }.padding(.top)
                    
                    VStack(spacing: 5) {
                        if !fastingManager.elapsed {
                            Text("Remaining Time")
                                .opacity(0.7)
                        } else {
                            Text("Extra time")
                                .opacity(0.7)
                        }
                       
                        Text(fastingManager.endTime, style: .timer)
                            .font(.title)
                            .fontWeight(.bold)
                    }.padding(.top)
                }
            }
        }
        .frame(width: 250, height: 250)
        .onReceive(timer, perform: { _ in
            fastingManager.track()
        })
    }
}

#Preview {
    FastingProgress().environmentObject(FastingManager())
}
