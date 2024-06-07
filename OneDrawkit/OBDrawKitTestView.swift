//
//  OBDrawKitTest.swift
//  OneDrawkit
//
//  Created by Timon Harz on 07.06.24.
//

import SwiftUI

struct OBDrawKitTestView: View {

  @State private var tool: DrawingTool = InkingTool(inkType: .pen, color: UIColor.black)
  @State private var availableTouches: Set<UITouch.TouchType> = [.pencil]

  @State private var selectedColor: SwiftUI.Color = SwiftUI.Color.black
  @State private var inkWidth: CGFloat = 4


    var body: some View {
      NavigationStack {
        VStack {
          toolbar()
            ZStack {
              ZoomableScrollView {
                CanvasViewRepresentable(usePencilKitIfPossible: .constant(false), tool: $tool, availableTouches: $availableTouches).frame(width: 595, height: 842).clipped()
              }

            }.border(.gray).shadow(color: SwiftUI.Color(.systemGray5), radius: 40, x: 0, y: 4)

        }
      }
    }
  @ViewBuilder func toolbar() -> some View {
    HStack {
      Button(action: {}) {
        Image(systemName: "pencil.tip")
          .font(.title)
          .fontWeight(.semibold)
      }
      Button(action: {}) {

      }
    }
  }
}

#Preview {
    OBDrawKitTestView()
}
