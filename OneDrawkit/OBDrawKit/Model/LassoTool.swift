//
//  LassoTool.swift
//  OneDrawkit
//
//  Created by Timon Harz on 07.06.24.
//

import Foundation
import PencilKit

public struct LassoTool: DrawingTool {
    public init() {}

    @available(iOS 13, *)
    public func toPKTool() -> PKTool {
        PKLassoTool()
    }
}
