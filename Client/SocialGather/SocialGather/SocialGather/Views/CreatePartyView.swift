//
//  CreateMatchView.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 23/05/23.
//

import SwiftUI

struct CreatePartyView: View {
    @EnvironmentObject var partyViewModel : PartyViewModel
    
    @State var matchName = ""
    @State var selectedSingle = true
    @State var selectedTeams = false
    @State var selectGames = false
    
    var body: some View {
        ZStack {
            Color.Background
                .ignoresSafeArea()
            VStack {
                Spacer()
                    .frame(maxHeight: 37)
                CustomTextField(title: "Choose a name", prompt: "Type your match name", text: $matchName)
                Spacer()
                    .frame(maxHeight: 37)
                CustomToggle(selected: $selectedSingle, title: "Choose the kind of match", content: "Single Player", showTitle: true)
                    .onTapGesture {
                        selectedSingle = true
                        selectedTeams = false
                    }
                CustomToggle(selected: $selectedTeams, title: "Choose the kind of match", content: "Teams", showTitle: false)
                    .onTapGesture {
                        selectedTeams = true
                        selectedSingle = false
                    }
                Spacer()
                doneButton
                NavigationLink("", isActive: $selectGames, destination: {
                    GameSelectionView()
                })
            }
            
        }
        .navigationTitle("Match Creation")
        .navigationBarTitleDisplayMode(.inline)
    }
    private var doneButton: some View {
        return Group {
            if matchName == "" {
                Button("Done") {}
                .buttonStyle(CustomButtonStyleDisabled(buttonType: .filled))
                .padding(.bottom)
            } else {
                Button("Done") {
                    partyViewModel.isMaster = true
                    partyViewModel.createParty(name: matchName, completion: {_ in})
                    selectGames = true
                }
                .buttonStyle(CustomButtonStyle(buttonType: .filled))
            }
        }
    }
}

struct CreateMatchView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePartyView()
    }
}
