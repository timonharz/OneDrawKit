//
//  OBStroke.swift
//  OneDrawkit
//
//  Created by Timon Harz on 03.06.24.
//

import Foundation
import CoreGraphics

public struct OBStroke {
    public var path: CGMutablePath
  public var points: [OBStrokePoint]
    public var brush: Brush
    public var isFillPath: Bool
    public var forces: [CGFloat]

  public init(path: CGMutablePath, points: [OBStrokePoint],  brush: Brush, isFillPath: Bool, forces: [CGFloat]) {
        self.path = path
    self.points = points
        self.brush = brush
        self.isFillPath = isFillPath
    self.forces = forces
    }

  var pathPoints: [CGPoint] {
    let path = path.copy()

    guard let path = path else { return [] }

    let points = path.points()
    return points
  }
}
public struct OBStrokePoint: Codable {
  public var location: CGPoint
  public var size: CGSize
  public var opactiy: CGFloat
  public var azimuth: CGFloat
  public var altitude: CGFloat
}
