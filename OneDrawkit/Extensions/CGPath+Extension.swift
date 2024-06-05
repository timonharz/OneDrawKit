//
//  CGPath+Extension.swift
//  OneDrawkit
//
//  Created by Timon Harz on 03.06.24.
//

import Foundation
import CoreGraphics
import UIKit

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
extension Array where Element == CGPoint {
    func toCGPath() -> CGPath? {
        let path = CGMutablePath()

        // Check if there are at least two points to form a path
        guard self.count > 1 else {
            // If not enough points, return nil or an empty path
            return nil
        }

        // Move to the first point
        path.move(to: self[0])

        // Add lines to each subsequent point
        for point in self.dropFirst() {
            path.addLine(to: point)
        }

        return path
    }
}
extension CGPoint {
    // Function to calculate the distance between two points
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt(pow((self.x - point.x), 2) + pow((self.y - point.y), 2))
    }
  // Extension to calculate distance between two CGPoints
      func distanceToPoint(to point: CGPoint) -> CGFloat {
          let deltaX = self.x - point.x
          let deltaY = self.y - point.y
          return sqrt(deltaX * deltaX + deltaY * deltaY)
      }
  // Function to calculate the speed of the stroke
      func strokeSpeed(to point: CGPoint, deltaTime: TimeInterval) -> CGFloat {
          let distanceTraveled = distance(to: point)
          // Speed = Distance / Time
          let speed = distanceTraveled / CGFloat(deltaTime)
          return speed
      }

}

extension UIBezierPath {
    func addRoundedRect(cornerRadius: CGFloat, for rect: CGRect) {
        let topLeft = CGPoint(x: rect.minX + cornerRadius, y: rect.minY)
        let topRight = CGPoint(x: rect.maxX - cornerRadius, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX + cornerRadius, y: rect.maxY)

        self.move(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
        self.addArc(withCenter: topLeft, radius: cornerRadius, startAngle: CGFloat.pi * 1.5, endAngle: CGFloat.pi * 2, clockwise: true)
        self.addArc(withCenter: topRight, radius: cornerRadius, startAngle: 0, endAngle: CGFloat.pi * 0.5, clockwise: true)
        self.addArc(withCenter: bottomRight, radius: cornerRadius, startAngle: CGFloat.pi * 0.5, endAngle: CGFloat.pi, clockwise: true)
        self.addArc(withCenter: bottomLeft, radius: cornerRadius, startAngle: CGFloat.pi, endAngle: CGFloat.pi * 1.5, clockwise: true)
        self.close()
    }
}
