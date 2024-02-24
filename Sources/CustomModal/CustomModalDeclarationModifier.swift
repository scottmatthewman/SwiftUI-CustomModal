//
//  CustomModalDeclarationModifier.swift
//  FullScreenModalCreator
//
//  Created by Scott Matthewman on 24/02/2024.
//

import SwiftUI

private struct CustomModalDeclarationModifier<ModalContent: View>: ViewModifier {
    var isPresented: Binding<Bool>
    var backgroundClick: BackgroundClickBehaviour
    var content: () -> ModalContent

    @EnvironmentObject private var fullScreenModal: CustomModalModel

    func body(content: Content) -> some View {
        content
            .onChange(of: isPresented.wrappedValue) { newValue in
                fullScreenModal.isPresented = newValue
                if newValue {
                    fullScreenModal.backgroundClickBehaviour = backgroundClick
                    fullScreenModal.content = AnyView(self.content())
                }
            }
            .onChange(of: fullScreenModal.isPresented) { newValue in
                if isPresented.wrappedValue != newValue {
                    isPresented.wrappedValue = newValue
                }
            }
    }
}

extension View {
    public func modal<ModalContent: View>(
        isPresented: Binding<Bool>,
        backgroundClick: BackgroundClickBehaviour = .dismiss,
        content: @escaping () -> ModalContent
    ) -> some View {
        modifier(
            CustomModalDeclarationModifier(
                isPresented: isPresented,
                backgroundClick: backgroundClick,
                content: content
            )
        )
    }
}

