//
//  Zoomable.swift
//  OneDrawkit
//
//  Created by Timon Harz on 08.05.24.
//

import Foundation
import SwiftUI
import UIKit

struct ZoomableScrollView<Content: View>: UIViewRepresentable {
    var content: () -> Content

  @AppStorage("isDrawing") private var isDrawing: Bool = false

    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        scrollView.maximumZoomScale = 10.0
        scrollView.minimumZoomScale = 0.75
        scrollView.bouncesZoom = true

        let hostedView = UIHostingController(rootView: content())
        hostedView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        hostedView.view.backgroundColor = .clear

        scrollView.addSubview(hostedView.view)
        scrollView.contentSize = hostedView.view.frame.size

        return scrollView
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // Update the hosted view here if needed
      print("Is drawing: \(isDrawing)")
      if isDrawing {
        uiView.isScrollEnabled = false
        uiView.bouncesZoom = false

      } else {
        uiView.isScrollEnabled = true
        uiView.bouncesZoom = true
      }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: ZoomableScrollView

        init(_ parent: ZoomableScrollView) {
            self.parent = parent
        }

        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return scrollView.subviews.first
        }
      func scrollViewDidZoom(_ scrollView: UIScrollView) {
        scaleView(view: scrollView, scale: scrollView.zoomScale)
      }
      private func scaleView(view: UIView, scale: CGFloat) {

        view.contentScaleFactor = scale * UIScreen.main.scale


        for subview in view.subviews {
          scaleView(view: subview, scale: scale)
        }
      }

    }
}
