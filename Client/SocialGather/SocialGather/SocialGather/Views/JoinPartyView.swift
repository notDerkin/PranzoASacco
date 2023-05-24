//
//  JoinMatchView.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 23/05/23.
//

import SwiftUI

struct JoinPartyView: View {
    @EnvironmentObject var partyViewModel : PartyViewModel
    @State var code: String = ""
    @State var newPlayer = false
    @State var newMatch = false
    var body: some View {
        NavigationView {
            ZStack {
                Color.Background
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    Spacer()
                        .frame(maxHeight: 80)
                    CustomTextField(title: "Insert the code", prompt: "Type your code", type: .code, text: $code)
                    Spacer()
                    VStack(spacing: 0) {
                        joinButton
                        Button("Create a match") {
                            newMatch.toggle()
                        }
                        .buttonStyle(CustomButtonStyle(buttonType: .stroke))
                    }
                    .padding(.vertical)
                    NavigationLink("", isActive: $newPlayer, destination: {
                        NewPlayerView(partyCode: code)
                    })
                    NavigationLink("", isActive: $newMatch, destination: {
                        CreatePartyView()
                    })
                }
            }

            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Text("SocialGather")
                        .font(.customTitle)
                        .padding(.top, 50)
                }
            }
        }
        
    }
    private var joinButton: some View {
        return Group {
            if code == "" {
                Button("Join a match") {
                }
                .buttonStyle(CustomButtonStyleDisabled(buttonType: .filled))
            } else {
                Button("Join a match") {
                    partyViewModel.currentParty.code = code
                    newPlayer = true
                }
                .buttonStyle(CustomButtonStyle(buttonType: .filled))
            }
        }
    }
}

struct JoinMatchView_Previews: PreviewProvider {
    static var previews: some View {
        JoinPartyView(code: "")
    }
}
