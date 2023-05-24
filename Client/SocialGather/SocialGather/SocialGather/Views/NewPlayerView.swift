//
//  NewPlayerView.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 24/05/23.
//

import SwiftUI

struct NewPlayerView: View {
    @EnvironmentObject var partyViewModel : PartyViewModel

    @State var playerName = ""
    @State var startGame = false
    var partyCode : String
    var body: some View {
        ZStack {
            Color.Background
                .ignoresSafeArea()
            VStack {
                CustomTextField(title: "Choose a name", prompt: "Type your name", text: $playerName)
                    .padding(.top)
                Spacer()
                NavigationLink("", isActive: $startGame, destination: {
                    WaitingView()
                })
                doneButton
            }
        }
        .navigationTitle("Welcome")
        .navigationBarTitleDisplayMode(.inline)
    }
    private var doneButton: some View {
        return Group {
            if playerName == "" {
                Button("Join") {}
                    .buttonStyle(CustomButtonStyleDisabled(buttonType: .filled))
                    .padding(.bottom)
            } else {
                Button("Join") {
                    partyViewModel.joinAParty(partyCode: partyCode, nickname: playerName, completion: {_ in })
                    partyViewModel.player.name = playerName
                    startGame = true
                    
                }
                    .buttonStyle(CustomButtonStyle(buttonType: .filled))
                    .padding(.bottom)
            }
        }
    }
}

//struct NewPlayerView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewPlayerView()
//    }
//}
