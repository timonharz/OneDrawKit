//
//  InkingContext.swift
//  OneDrawkit
//
//  Created by Timon Harz on 07.06.24.
//

import Foundation
import UIKit

final class DrawingLayer: CAShapeLayer {}

final class InkingContext {
    var points: [CGPoint] = []
    var path: UIBezierPath?
    var pathLayer: DrawingLayer?
    var imageLayer: CALayer?

    func reset() {
        points = []
        path = nil
        pathLayer = nil
        imageLayer = nil
    }
}
