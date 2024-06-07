//
//  UIBezierPath+Ext.swift
//  OneDrawkit
//
//  Created by Timon Harz on 07.06.24.
//

import Foundation
import UIKit

extension UIBezierPath {
    static func interpolate(points: [CGPoint], closed: Bool = false) -> UIBezierPath {
        guard !points.isEmpty else { return .init() }

        let path = UIBezierPath()

        path.move(to: points[0])
        points.forEach {
            path.addLine(to: $0)
        }

        if closed {
            path.close()
        }
        return path
    }
}
