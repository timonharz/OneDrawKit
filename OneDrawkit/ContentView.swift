//
//  ContentView.swift
//  OneDrawkit
//
//  Created by Timon Harz on 08.05.24.
//

import Foundation
import SwiftUI
import CoreGraphics
import UIKit

struct ContentView: View {
  let drawView = SwiftyDrawView()

  @State private var isDrawing: Bool = false
    var body: some View {
      ZStack {
        VStack {

          HStack {
            Button(action: {
              drawView.brush = .default
              drawView.brush.adjustedWidthFactor = 0
            }) {
              Image(systemName: "pencil.tip")
            }
            Button(action: {
              drawView.brush = .marker

            }) {
              Image(systemName: "highlighter")
            }
            Button(action: {
              drawView.brush = Brush(brushType: .eraser, adjustedWidthFactor: 1, blendMode: .clear)
              drawView.brush.width = 25

            }) {
              Image(systemName: "eraser")

            }
            Button(action: {
              drawView.brush = .selection
            }) {
              Image(systemName: "lasso")
            }
            Button(action: {
              drawView.shouldFillPath = true

            }) {
              Image(systemName: "rectangle")
            }
          }
            VStack {
              SwiftyDrawViewRepresentable(drawView: drawView)
            }.frame(width: 595, height: 842).border(.gray)

        }
      }
    }
  private func setupCanvas() {
    drawView.allowedTouchTypes = [.pencil]
  }
}

#Preview {
    ContentView()
}
