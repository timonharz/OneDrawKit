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
        let scrollView = CustomScrollView()
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
          print("Scale: \(scale)")
          if scale < 12.5 {
            view.contentScaleFactor = scale * UIScreen.main.scale
            for subview in view.subviews {
              scaleView(view: subview, scale: scale)
            }
          }
        }
    }
}

class CustomScrollView: UIScrollView {
    override func touchesShouldBegin(_ touches: Set<UITouch>, with event: UIEvent?, in view: UIView) -> Bool {
        // Allow touches to begin only if they are from fingers, not from a stylus
        if let touch = touches.first, touch.type == .pencil {
            return false
        }
        return super.touchesShouldBegin(touches, with: event, in: view)
    }

    override func touchesShouldCancel(in view: UIView) -> Bool {
        // Cancel touches only if they are from fingers, not from a stylus
        if let gestureRecognizers = view.gestureRecognizers {
            for gesture in gestureRecognizers {
                if let touch = gesture as? UITouch, touch.type == .pencil {
                    return false
                }
            }
        }
        return super.touchesShouldCancel(in: view)
    }
}
