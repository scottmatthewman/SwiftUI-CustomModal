//
//  DismissModalAction.swift
//  FullScreenModalCreator
//
//  Created by Scott Matthewman on 24/02/2024.
//

import SwiftUI

public struct DismissModalAction {
    internal var action: () -> Void

    func callAsFunction() {
        action()
    }
}

struct DismissModalActionKey: EnvironmentKey {
    static let defaultValue: DismissModalAction = DismissModalAction { }
}

extension EnvironmentValues {
    public var dismissModal: DismissModalAction {
        get { self[DismissModalActionKey.self] }
        set { self[DismissModalActionKey.self] = newValue }
    }
}
