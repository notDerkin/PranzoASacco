//
//  AnswerBox.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 24/05/23.
//

import SwiftUI

enum BoxType {
    case correct, wrong, none
}

struct AnswerBox: View {
    @EnvironmentObject var partyViewModel: PartyViewModel
    @State var selected = false
    var content: String = ""
    @State var boxType: BoxType
    @State var showTitle = true
    var correctAnswer = ""
    @State var nextQuestion = false
    @State var questionNumber = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                HStack {
                    HStack(spacing: 5) {
                        if !partyViewModel.isMaster {
                            Circle()
                                .stroke()
                                .foregroundColor(selected ? .accentColor : .secondary)
                                .padding(15)
                                .frame(height: 50)
                                .overlay {
                                    Circle()
                                        .foregroundColor(selected ? .accentColor : .clear)
                                        .padding(18)
                                }
                        }
                        Text(content)
                        Spacer()
                        NavigationLink("", isActive: $nextQuestion, destination: {QuestionView()})
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 5)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.white)
                            .frame(width: UIScreen.main.bounds.width - 80)
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
                            .foregroundColor(boxType == .correct ? .green : (boxType == .wrong ? .red : .secondary))
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width - 80)
        .onTapGesture {
            if !selected {
                selected = true
                partyViewModel.postPlayerPoint(partyCode: partyViewModel.currentParty.code, nickName: partyViewModel.player.name, points:  content == correctAnswer ? 10 : 0, completion: {_ in})
                
                    partyViewModel.currentQuestion += 1
                    nextQuestion = true
                
            }
        }
        .onAppear{
            nextQuestion = false
        }
    }
}

struct AnswerBox_Previews: PreviewProvider {
    static var previews: some View {
        AnswerBox(content: "helloooodasf i dsanf a danga dosfna adfns faf dn fahnda f as'aijfa' adhfai sadhfpao dhapiosfh a adsphf a", boxType: .none)
    }
}
