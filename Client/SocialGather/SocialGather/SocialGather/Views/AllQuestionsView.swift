//
//  AllQuestionsView.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 24/05/23.
//

import SwiftUI

struct AllQuestionsView: View {
    @EnvironmentObject var partyViewModel : PartyViewModel
    @State var showDeleteAlert = false
    @State var codeView = false
    var body: some View {
        ZStack {
            Color.Background
                .ignoresSafeArea()
            VStack {
                ScrollView(showsIndicators: false) {
                    ForEach(partyViewModel.questions, id: \.self) { question in
                        AddedQuestionCard(questionTitle: question.text, editAction: {}, deleteAction: {
                            showDeleteAlert.toggle()
                        })
                        .alert(isPresented: $showDeleteAlert, content: {
                            Alert(title: Text("Do you want to remove this question?"), primaryButton: .destructive(Text("Yes"), action: {
                                partyViewModel.questions.removeAll(where: {$0 == question})
                            }), secondaryButton: .cancel(Text("No")))
                        })
                    }
                }
                Button("Save") {
                    codeView.toggle()
                    partyViewModel.postQuestions(partyCode: partyViewModel.currentParty.code, questions: partyViewModel.questions, completion: { response in
                        if response {
    //                        partyViewModel.startGame(partyCode: partyViewModel.currentParty.code, completion: {_ in})
                        }
                    })
                    
                }
                    .buttonStyle(CustomButtonStyle(buttonType: .filled))
                    .padding(.bottom)
                NavigationLink("", isActive: $codeView, destination: {
                    CodeView()
                })
            }
        }
        .navigationTitle("Your Questions")
    }
}

struct AllQuestionsView_Previews: PreviewProvider {
    static var previews: some View {
        AllQuestionsView()
    }
}
