//
//  DiwaliCountdownView.swift
//  Diwali
//
//  Created by Brinda Davda on 22/10/24.
//

import SwiftUI
import AVKit

struct DiwaliCountdownView: View {
  // Countdown to Diwali (Set Diwali date)
  @State private var timeRemaining = timeUntilDiwali()
  let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
  
  // Store the position of the tap
  @State private var diyaPosition: CGPoint? = nil
  @State private var shouldShowFirework = false
  
  // Create an AVPlayer for the video
     private let videoPlayer = AVPlayer(url: Bundle.main.url(forResource: "diwaliBackground", withExtension: "mp4")!)

    var body: some View {
        ZStack {
          // Video background
                      VideoBackgroundView(player: videoPlayer)
                          .ignoresSafeArea()
                          .onAppear {
                              // Loop the video
                              videoPlayer.play()
                              videoPlayer.isMuted = true  // Optional: mute the video if you don't want sound
                              NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: videoPlayer.currentItem, queue: .main) { _ in
                                  videoPlayer.seek(to: .zero)
                                  videoPlayer.play()
                              }
                          }
                          .offset(x: -50)
                          .disabled(true)
            
            VStack {
                // Title
                Text("Diwali Countdown")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
              
              Spacer()
              
              HStack(spacing: 20) {
                FlickerLightView()
                DiyaView()
                FlickerLightView()
                DiyaView()
                FlickerLightView()
              }
              .padding(.bottom, 30)
                 
                // Timer Display
              VStack{
                Text(timeRemaining.days)
                    .font(.system(size: 40, weight: .bold))
                    .multilineTextAlignment(.center)
                    
                    
                Text(timeRemaining.time)
                  .font(.system(size: 40, weight: .bold))
    
                }
              .foregroundColor(.yellow)
              .onReceive(timer) { _ in
                  timeRemaining = timeUntilDiwali()
              }
                // Flickering diya lights
              
                
                HStack(spacing: 20) {
                  FlickerLightView()
                  DiyaView()
                  FlickerLightView()
                  DiyaView()
                  FlickerLightView()
                }
                .padding(.top, 30)
                

              Spacer()
             
            }
        
        }
    }
}


struct DiwaliCountdownView_Previews: PreviewProvider {
    static var previews: some View {
        DiwaliCountdownView()
    }
}
