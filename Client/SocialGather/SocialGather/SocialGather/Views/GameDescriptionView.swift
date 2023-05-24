//
//  GameDescriptionView.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 23/05/23.
//

import SwiftUI

struct GameDescriptionView: View {
    @Environment(\.presentationMode) var presentation
    var gameTitle: String
    var gameDescription: String
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text(gameTitle)
                        .font(.title)
                        .bold()
                    Spacer()
                }
                Text(gameDescription)
                    .foregroundColor(.text)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.accentColor.opacity(0.12))
                    }
                Spacer()
                Button("Got it") {
                    presentation.wrappedValue.dismiss()
                }
                .buttonStyle(CustomButtonStyle(buttonType: .filled))
            }
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Header(title: gameTitle)
                }
            }
        }
    }
}

struct GameDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        GameDescriptionView(gameTitle: "Game Title", gameDescription: "This is the description of the game, it is a long description since it describe the game and how it works, it is amazing how good and long this description is")
    }
}
