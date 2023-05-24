//
//  GameCard.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 23/05/23.
//

import SwiftUI

struct GameCard: View {
    var gameTitle: String
    var gamePrompt: String
    @State var showAddQuestion = false
    @State var showDetailView = false
    @Binding var questions: [Question]
    @State var isActive = true
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(gameTitle)
                    .font(.headline)
                Spacer()
                if isActive {
                    Text("\(questions.count)")
                        .padding(.trailing, 5)
                }
                Button(action: {
                    if isActive {
                        showAddQuestion.toggle()
                    }
                }, label: {
                    Image(systemName: "plus")
                        .font(.headline)
                })
            }
            HStack {
                Text(gamePrompt)
                    .foregroundColor(.text)
                    .padding()
                Spacer()
            }
                .background {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.accentColor.opacity(0.12))
                }
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - 40)
        .opacity(isActive ? 1 : 0.3)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)
        }
        .onTapGesture {
            if isActive {
                showDetailView.toggle()
            }
        }
        .sheet(isPresented: $showAddQuestion, content: {
            AddQuizQuestionView(title: gameTitle)
        })
        .sheet(isPresented: $showDetailView, content: {
            GameDetailView(gameTitle: gameTitle, gameDescription: gamePrompt)
        })
    }
}

struct GameCard_Previews: PreviewProvider {
    static var previews: some View {
        GameCard(gameTitle: "Title", gamePrompt: "Prompt", questions: .constant([Question(text: "", answers: [""], correctAnswer: "")]))
    }
}
