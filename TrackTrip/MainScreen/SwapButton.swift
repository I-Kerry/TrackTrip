//
//  SwapButton.swift
//  TrackTrip
//
//  Created by Kirill Maidanovich on 2026/7/7.
//

import SwiftUI

struct SwapButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "arrow.2.squarepath")
                .font(.system(size: 15))
                .foregroundStyle(.blue)
                .frame(width: 36, height: 36)
                .background(Circle().fill(Color.white))
        }
        .buttonStyle(.plain)
    }
}


#Preview {
    SwapButton(action: {})
}
