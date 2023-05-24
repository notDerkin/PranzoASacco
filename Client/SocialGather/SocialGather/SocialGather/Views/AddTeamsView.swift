//
//  AddTeamsView.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 23/05/23.
//

import SwiftUI

struct AddTeamsView: View {
    @State var openNewTeam = false
    @State var showEditView = false
    @State var showDeletingAlert = false
    @State var teams: [String] = []
    var body: some View {
        ZStack {
            Color.Background
                .ignoresSafeArea()
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    Button(action: {
                        openNewTeam.toggle()
                    }, label: {
                        HStack {
                            Spacer()
                            Image(systemName: "plus")
                            Spacer()
                        }
                    })
                    .padding(8)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.white)
                    }
                    .padding()
                    if teams == [] {
                        Spacer()
                        Text("Add a team")
                            .foregroundColor(.secondary)
                    } else {
                        VStack(spacing: 16) {
                            ForEach(teams, id: \.self) { team in
                                AddedTeamCard(teamName: team, editAction: {
                                    showEditView.toggle()
                                }, deleteAction: {
                                    showDeletingAlert = true
                                })
                                .alert(isPresented: $showDeletingAlert, content: {
                                    Alert(title: Text("Do you want to remove this team?"), primaryButton: .destructive(Text("Yes"), action: {teams.removeAll(where: {$0 == team})}), secondaryButton: .cancel(Text("No")))
                                })
                                .sheet(isPresented: $showEditView, content: {
                                    CreateTeamView(teamName: team, teams: $teams, isEditing: true)
                                })
                            }
                        }
                    }
                }
                doneButton
            }
            .navigationTitle("Teams")
            
        }
        .sheet(isPresented: $openNewTeam, content: {
            CreateTeamView(teams: $teams, isEditing: false)
        })
        
    }
    private var doneButton: some View {
        return Group {
            if teams == [] {
                Button("Done") {}
                    .buttonStyle(CustomButtonStyleDisabled(buttonType: .filled))
                    .padding(.bottom)
            } else {
                Button("Done") {}
                    .buttonStyle(CustomButtonStyle(buttonType: .filled))
                    .padding(.bottom)
            }
        }
    }
}

struct AddTeamsView_Previews: PreviewProvider {
    static var previews: some View {
        AddTeamsView()
    }
}
