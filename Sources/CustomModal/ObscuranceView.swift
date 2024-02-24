//
//  ObscuranceView.swift
//  FullScreenModalCreator
//
//  Created by Scott Matthewman on 24/02/2024.
//

import SwiftUI

struct ObscuranceView: View {
    var body: some View {
        Rectangle()
            .fill(.black.opacity(0.4))
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ObscuranceView()
}
