//
//  AddedTeamCard.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 23/05/23.
//

import SwiftUI

struct AddedTeamCard: View {
    var teamName: String
    var editAction: () -> Void
    var deleteAction: () -> Void
    var body: some View {
        HStack {
            Text(teamName)
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
        .padding(.trailing, 4)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)
        }
        .padding(.horizontal)
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

struct AddedTeamCard_Previews: PreviewProvider {
    static var previews: some View {
        AddedTeamCard(teamName: "Team name", editAction: {}, deleteAction: {})
    }
}
