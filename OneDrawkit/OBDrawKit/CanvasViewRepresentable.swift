//
//  CanvasViewRepresentable.swift
//  OneDrawkit
//
//  Created by Timon Harz on 07.06.24.
//

import Foundation
import UIKit
import SwiftUI
import PencilKit

struct CanvasViewRepresentable: UIViewRepresentable {
    @Binding var usePencilKitIfPossible: Bool
    @Binding var tool: DrawingTool
    @Binding var availableTouches: Set<UITouch.TouchType>

    class Coordinator: NSObject {
        var parent: CanvasViewRepresentable

        init(parent: CanvasViewRepresentable) {
            self.parent = parent
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> CanvasView {
        let canvasView = CanvasView(frame: .zero)
        canvasView.usePencilKitIfPossible = usePencilKitIfPossible
        canvasView.tool = tool
        canvasView.availableTouches = availableTouches
        return canvasView
    }

    func updateUIView(_ uiView: CanvasView, context: Context) {
        uiView.usePencilKitIfPossible = usePencilKitIfPossible
        uiView.tool = tool
        uiView.availableTouches = availableTouches
    }
}
