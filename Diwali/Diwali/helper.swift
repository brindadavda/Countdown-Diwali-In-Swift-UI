//
//  FireworkView.swift
//  Diwali
//
//  Created by Brinda Davda on 22/10/24.
//

import SwiftUI
import AVKit

// Flickering light (diya) effect
struct FlickerLightView: View {
    @State private var flicker = false
    
    var body: some View {
        Circle()
            .fill(Color.random())
            .frame(width: 50, height: 50)
            .shadow(color: .orange, radius: 20)
            .opacity(flicker ? 1 : 0.5)
            .animation(Animation.easeInOut(duration: 0.5).repeatForever(), value: flicker)
            .onAppear {
                flicker.toggle()
            }
    }
}

// Helper function to calculate time until Diwali
func timeUntilDiwali() -> (days : String , time : String) {
    let calendar = Calendar.current
    let diwaliDate = Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 1))!
    let components = calendar.dateComponents([.day, .hour, .minute, .second], from: Date(), to: diwaliDate)
    
  // Calculate the number of days and time components
      let days = components.day ?? 0
      let hours = components.hour ?? 0
      let minutes = components.minute ?? 0
      let seconds = components.second ?? 0

  // Prepare the first part: "8 Days"
      let dayString = String(format: "%d Days", days)

      // Center the day string in a width of 20 characters (adjust as needed)
      let centeredDayString = dayString.padding(toLength: 20, withPad: " ", startingAt: 0)

      // Prepare the time string: "hh:mm:ss"
      let timeString = String(format: "%02d : %02d : %02d", hours, minutes, seconds)

      // Combine both parts with a newline
      return (centeredDayString ,timeString)
}

// Video Background View
struct VideoBackgroundView: View {
    let player: AVPlayer
    
    var body: some View {
        VideoPlayer(player: player)
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
    }
}
