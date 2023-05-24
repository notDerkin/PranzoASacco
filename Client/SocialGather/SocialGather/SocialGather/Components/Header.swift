//
//  Divider.swift
//  SocialGather
//
//  Created by Andrea Masturzo on 23/05/23.
//

import SwiftUI

struct Header: View {
    var title: String
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
            Rectangle()
                .frame(width: UIScreen.main.bounds.width, height: 1)
                .foregroundColor(.secondary)
                .ignoresSafeArea(.all, edges: [.horizontal])
        }
    }
    
    private var header: some View {
        return Rectangle()
            .frame(width: UIScreen.main.bounds.width, height: 1)
            .foregroundColor(.secondary)
            .ignoresSafeArea(.all, edges: [.horizontal])
    }
}

struct Divider_Previews: PreviewProvider {
    static var previews: some View {
        Header(title: "Title")
    }
}
