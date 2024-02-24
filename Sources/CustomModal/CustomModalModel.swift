//
//  CustomModalModel.swift
//  FullScreenModalCreator
//
//  Created by Scott Matthewman on 24/02/2024.
//

import SwiftUI

internal class CustomModalModel: ObservableObject {
    @Published var isPresented: Bool = false
    var backgroundClickBehaviour: BackgroundClickBehaviour = .dismiss
    var content: AnyView = AnyView(EmptyView())

    var dismiss: DismissModalAction {
        DismissModalAction(action: { self.isPresented = false })
    }

    func onBackgroundClick() {
        if backgroundClickBehaviour == .dismiss {
            isPresented = false
        }
    }
}
