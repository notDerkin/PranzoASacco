//
//  CreateTeamView.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 23/05/23.
//

import SwiftUI

struct CreateTeamView: View {
    @Environment(\.presentationMode) var presentation
    @State var teamName = ""
    @Binding var teams: [String]
    @State var isEditing : Bool
    @State private var actualTeamName = ""
    var body: some View {
        ZStack {
            Color.Background
                .ignoresSafeArea()
            VStack {
                CustomTextField(title: "Choose a name", prompt: "Type a team name", text: $teamName)
                    .padding(.top, 90)
                Spacer()
                saveButton
            }
            .onAppear {
                actualTeamName = teamName
            }
        }
        
        .navigationTitle(teamName == "" ? "New Team" : teamName)
    }
    private var saveButton: some View {
        return Group {
            if isEditing {
                if teamName == "" {
                    Button("Save") {}
                        .buttonStyle(CustomButtonStyleDisabled(buttonType: .filled))
                        .padding(.bottom)
                } else {
                    Button("Save") {
                        let teamIndex = teams.firstIndex(where: {$0 == actualTeamName})
                        teams.remove(at: teamIndex!)
                        teams.append(teamName)
                        presentation.wrappedValue.dismiss()
                    }
                    .buttonStyle(CustomButtonStyle(buttonType: .filled))
                    .padding(.bottom)
                }
                
            } else {
                if teamName == "" {
                    Button("Save") {}
                        .buttonStyle(CustomButtonStyleDisabled(buttonType: .filled))
                        .padding(.bottom)
                } else {
                    Button("Save") {
                        teams.append(teamName)
                        presentation.wrappedValue.dismiss()
                    }
                    .buttonStyle(CustomButtonStyle(buttonType: .filled))
                    .padding(.bottom)
                }
            }
        }
    }
}

struct CreateTeamView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTeamView(teams: .constant([""]), isEditing: false)
    }
}
