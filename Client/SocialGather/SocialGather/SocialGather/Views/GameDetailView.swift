//
//  GameDetailView.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 23/05/23.
//

import SwiftUI

struct GameDetailView: View {
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var partyViewModel: PartyViewModel
    var gameTitle: String
    var gameDescription: String
    @State var showDeletingAlert = false
    var body: some View {
        ZStack {
            Color.Background
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Text(gameTitle)
                    .font(.title)
                    .bold()
                    .padding(.horizontal)
                HStack {
                    Text(gameDescription)
                        .foregroundColor(.text)
                        .padding()
                    Spacer()
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.accentColor.opacity(0.12))
                        .padding()
                }
                
                ForEach(partyViewModel.questions, id: \.self) { question in
                    AddedQuestionCard(questionTitle: question.text, editAction: {}, deleteAction: {
                        showDeletingAlert = true
                    })
                    .alert(isPresented: $showDeletingAlert, content: {
                        Alert(title: Text("Do you want to remove this question?"), primaryButton: .destructive(Text("Yes"), action: {
                            partyViewModel.questions.removeAll(where: {$0 == question})
                        }), secondaryButton: .cancel(Text("No")))
                    })
                }
                Spacer()
                Button("Done") {
                    presentation.wrappedValue.dismiss()
                }
                .buttonStyle(CustomButtonStyle(buttonType: .filled))
            }
            .padding()
        }
    }
}

struct GameDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GameDetailView(gameTitle: "Question Title", gameDescription: "Question Description")
    }
}
