//
//  CGPath+Extension.swift
//  OneDrawkit
//
//  Created by Timon Harz on 03.06.24.
//

import Foundation
import CoreGraphics

extension CGPath {
    func points() -> [CGPoint] {
        var points: [CGPoint] = []

        self.applyWithBlock { element in
            let pointsPointer = element.pointee.points
            switch element.pointee.type {
            case .moveToPoint, .addLineToPoint:
                points.append(pointsPointer.pointee)
            case .addQuadCurveToPoint:
                points.append(pointsPointer.pointee)
                points.append(pointsPointer.advanced(by: 1).pointee)
            case .addCurveToPoint:
                points.append(pointsPointer.pointee)
                points.append(pointsPointer.advanced(by: 1).pointee)
                points.append(pointsPointer.advanced(by: 2).pointee)
            case .closeSubpath:
                break
            @unknown default:
                break
            }
        }

        return points
    }
}
