//
//  PKEraserTool+Ext.swift
//  OneDrawkit
//
//  Created by Timon Harz on 07.06.24.
//

import Foundation
import PencilKit

@available(iOS 13, *)
extension PKEraserTool.EraserType {
    var toEraserType: EraserTool.EraserType {
        switch self {
        case .bitmap: return .bitmap
        case .vector: return .vector
        case .fixedWidthBitmap: return .bitmap
        }
    }
}
