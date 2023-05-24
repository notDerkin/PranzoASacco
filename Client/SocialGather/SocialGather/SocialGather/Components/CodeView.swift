//
//  CodeView.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 24/05/23.
//

import SwiftUI

struct CodeView: View {
    @EnvironmentObject var partyViewModel : PartyViewModel
    var body: some View {
        NavigationView {
            ZStack {
                Color.Background
                    .ignoresSafeArea()
                VStack {
                    HStack {
                        Text("Share this code")
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                    HStack {
                        Spacer()
                        Text(partyViewModel.currentParty.code)
                            .font(.customTitle)
                        Spacer()
                    }
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.white)
                            .padding(.horizontal)
                    }
                    Spacer()
                    Button("Start Game") {
                        partyViewModel.startGame(partyCode: partyViewModel.currentParty.code, completion: { _ in})
                    }
                    .buttonStyle(CustomButtonStyle(buttonType: .filled))
                    .padding(.bottom)
                }
            }
            .navigationTitle("Start Game")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct CodeView_Previews: PreviewProvider {
    static var previews: some View {
        CodeView()
    }
}
