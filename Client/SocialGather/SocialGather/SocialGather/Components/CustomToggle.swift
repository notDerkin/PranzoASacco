//
//  CustomToggle.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 23/05/23.
//

import SwiftUI

struct CustomToggle: View {
    @Binding var selected: Bool
    var title: String = ""
    var content: String
    @State var showTitle = true
    var body: some View {
        VStack(alignment: .leading) {
            if showTitle {
                Text(title)
            }
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white)
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .frame(maxHeight: 47)
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1)
                    .foregroundColor(.secondary)
                    .frame(width: UIScreen.main.bounds.width - 40)
                    .frame(maxHeight: 47)
                    .overlay(alignment: .leading) {
                        HStack {
                            Circle()
                                .stroke()
                                .foregroundColor(selected ? .accentColor : .secondary)
                                .padding(15)
                                .overlay {
                                    Circle()
                                        .foregroundColor(selected ? .accentColor : .clear)
                                        .padding(18)
                                }
                            Text(content)
                                .padding(.trailing)
                        }
                    }
            }
        }
    }
}

struct CustomToggle_Previews: PreviewProvider {
    static var previews: some View {
        CustomToggle(selected: .constant(false), title: "Title", content: "Content")
    }
}
