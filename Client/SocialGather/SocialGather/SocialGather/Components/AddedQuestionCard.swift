//
//  AddedGameCard.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 23/05/23.
//

import SwiftUI

struct AddedQuestionCard: View {
    var questionTitle: String
    var editAction: () -> Void
    var deleteAction: () -> Void
    var body: some View {
        HStack {
            Text(questionTitle)
                .font(.system(size: 14, weight: .semibold))
            Spacer()
            Menu(content: {
                deleteButton
                editButton
            }, label: {
                Image(systemName: "ellipsis.circle")
            })
        }
        .padding(.vertical, 8)
        .padding(.leading, 12)
        .padding(.trailing, 8)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)
                .frame(width: UIScreen.main.bounds.width - 40)
        }
        .padding()
    }
    private var editButton: some View {
        return Button(action: editAction, label: {
            HStack {
                Text("Edit")
                Image(systemName: "square.and.pencil")
            }
        })
    }
    
    private var deleteButton: some View {
        return Button(role: .destructive, action: deleteAction, label: {
            HStack {
                Text("Delete")
                Image(systemName: "trash")
            }
        })
    }
}

struct AddedQuestionCard_Previews: PreviewProvider {
    static var previews: some View {
        AddedQuestionCard(questionTitle: "Game Title", editAction: {}, deleteAction: {})
    }
}
