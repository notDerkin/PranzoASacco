//
//  WaitingView.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 24/05/23.
//

import SwiftUI

struct WaitingView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @EnvironmentObject var partyViewModel : PartyViewModel
    
    @State var gameStarted : Bool = false
    
    var body: some View {
        ZStack {
            
            Color.Background
                .ignoresSafeArea()
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 40)
            Text("The Match \n is going to start soon!")
                .foregroundColor(.text)
                .font(.customTitle)
                .padding(.horizontal, 30)
                .multilineTextAlignment(.center)
                NavigationLink("", isActive: $gameStarted, destination: {QuestionView()})
        }
        .navigationBarBackButtonHidden(true)
        .onReceive(timer){ _ in
            partyViewModel.getParty(partyCode: partyViewModel.currentParty.code, completion: { party in
                print( partyViewModel.currentParty.code)
                print("called")
                guard let party = party else{return}
                print("not started")
                print(party)
        
                if party.isGameStarted {
                    print("started")
                    gameStarted = true 
                    //TODO: Stop timer
                }
            })
        }
    }
}

//struct WaitingView_Previews: PreviewProvider {
//    static var previews: some View {
//        WaitingView()
//    }
//}
