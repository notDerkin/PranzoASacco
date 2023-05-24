//
//  Timer.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 24/05/23.
//

import SwiftUI

struct TimerView: View {
    @State var timeRemaining: String = "2:30"
    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: "timer.circle")
            Text(timeRemaining)
        }
        .font(.headline)
        .padding(5)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.accentColor.opacity(0.12))
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
