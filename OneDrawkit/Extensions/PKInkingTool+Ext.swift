//
//  PKInkingTool+Ext.swift
//  OneDrawkit
//
//  Created by Timon Harz on 07.06.24.
//

import Foundation
import PencilKit

@available(iOS 13, *)
extension PKInkingTool.InkType {
    var toInkType: InkingTool.InkType {
        switch self {
        case .pen: return .pen
        case .pencil: return .pencil
        case .marker: return .marker

        @unknown default:
          return .pen
        }
    }
}
