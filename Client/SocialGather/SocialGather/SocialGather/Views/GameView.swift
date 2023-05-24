//
//  GameView.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 24/05/23.
//

import SwiftUI
// TODO: Componente segmentato per le domande, game view, views del player

struct GameView: View {
    @EnvironmentObject var partyViewModel: PartyViewModel
    var body: some View {
        ZStack {
            Color.Background
                .ignoresSafeArea()
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 40)
            
            if partyViewModel.isMaster == true {
                
            } else {
                
            }
            
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
