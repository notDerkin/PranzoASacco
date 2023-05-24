//
//  TitleAndTimer.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 24/05/23.
//

import SwiftUI

struct QuestionHeader: View {
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.customTitle)
                .foregroundColor(.text)
            Spacer()
            TimerView()
        }
        .padding()
    }
}

struct QuestionHeader_Previews: PreviewProvider {
    static var previews: some View {
        QuestionHeader(title: "Title")
    }
}
