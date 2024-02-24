//
//  CustomModalRootModifier.swift
//  FullScreenModalCreator
//
//  Created by Scott Matthewman on 24/02/2024.
//

import SwiftUI

struct ModalPresentationModifier: ViewModifier {
    var minWidth: CGFloat
    @ScaledMetric(relativeTo: .body) private var cornerRadius = 20
    @ScaledMetric(relativeTo: .body) private var padding = 10

    func body(content: Content) -> some View {
        content
            .padding(padding)
            .frame(minWidth: minWidth)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.background)
                    .shadow(radius: 10)
            )
            .padding()
    }
}

extension View {
    public func modalPresentation(minWidth: CGFloat = 300) -> some View {
        modifier(ModalPresentationModifier(minWidth: minWidth))
    }
}


struct CustomModalRootModifier: ViewModifier {
    @StateObject var modalModel: CustomModalModel = CustomModalModel()

    func body(content: Content) -> some View {
        ZStack {
            content
            if modalModel.isPresented {
                ObscuranceView()
                    .onTapGesture(perform: modalModel.onBackgroundClick)
                    .zIndex(1)

                modalModel.content
                    .modalPresentation(minWidth: 300)
                    .transition(
                        .asymmetric(
                            insertion: .scale.combined(with: .opacity),
                            removal: .move(edge: .bottom).combined(with: .opacity)
                        )
                    )
                    .zIndex(2)
            }
        }
        .animation(.easeInOut, value: modalModel.isPresented)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environment(\.dismissModal, modalModel.dismiss)
        .environmentObject(modalModel)
    }
}

extension View {
    public func customModalRoot() -> some View {
        modifier(CustomModalRootModifier())
    }
}
