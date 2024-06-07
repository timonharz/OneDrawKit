//
//  DrawingTool.swift
//  OneDrawkit
//
//  Created by Timon Harz on 07.06.24.
//

import Foundation
import PencilKit

public protocol DrawingTool {
    @available(iOS 13, *)
    func toPKTool() -> PKTool
}
