//
//  CustomPageController.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 24/05/23.
//

import SwiftUI

struct CustomPageController: View {
    @EnvironmentObject var partyViewModel: PartyViewModel
    @State var step = 0
    @Binding var doneQuestion: Bool
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(partyViewModel.questions, id: \.self) { question in
                    RoundedRectangle(cornerRadius: 8)
                        .fill(doneQuestion ? Color.accentColor : .secondary)
                        .frame(width: 20, height: 5)
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width - 80)
    }
}

struct CustomPageController_Previews: PreviewProvider {
    static var previews: some View {
        CustomPageController(doneQuestion: .constant(false))
    }
}
