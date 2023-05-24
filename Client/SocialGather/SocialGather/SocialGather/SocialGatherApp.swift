//
//  SocialGatherApp.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 22/05/23.
//

import SwiftUI

@main
struct SocialGatherApp: App {
    @StateObject var partyViewModel : PartyViewModel = PartyViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            JoinPartyView()
                .environmentObject(partyViewModel)
        }
    }
}
