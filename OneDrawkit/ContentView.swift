//
//  ContentView.swift
//  OneDrawkit
//
//  Created by Timon Harz on 08.05.24.
//

import SwiftUI

struct ContentView: View {
  let drawView = SwiftyDrawView()
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
              drawView.brush = Brush(adjustedWidthFactor: 1, blendMode: .clear)
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
              drawView.brush = Brush()
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
    drawView.allowedTouchTypes = [.finger, .pencil]
  }
}

#Preview {
    ContentView()
}
