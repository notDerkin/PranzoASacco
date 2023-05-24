//
//  MiniGameSelectionView.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 23/05/23.
//

import SwiftUI

struct GameSelectionView: View {
    @EnvironmentObject var partyViewModel: PartyViewModel
    @State var games: [String : String] = ["Single-choice Question Round": "Create a question with only one correct answer", "Content-based Question Round": "Coming Soon", "Guess the desk": "Coming Soon", "Draw this": "Coming Soon"]
    @State var navigateToOverview = false
    var body: some View {
        ZStack {
            Color.Background
                .ignoresSafeArea()
            VStack {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        ForEach(games.sorted(by: >), id: \.key) { key, value in
                            VStack {
                                GameCard(gameTitle: "\(key)", gamePrompt: "\(value)", questions: $partyViewModel.questions, isActive: key == "Single-choice Question Round" ? true : false)
                            }
                            
                        }
                    }
                }
                NavigationLink("", isActive: $navigateToOverview, destination: {
                    AllQuestionsView()
                })
                Button("Save") {
                    navigateToOverview = true
                }
                    .buttonStyle(CustomButtonStyle(buttonType: .filled))
                    .padding(.bottom)
            }
        }
    }
}

struct GameSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GameSelectionView()
    }
}
