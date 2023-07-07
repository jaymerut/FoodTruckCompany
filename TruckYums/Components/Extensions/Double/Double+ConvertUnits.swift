//
//  Double+ConvertUnits.swift
//  TruckYums
//
//  Created by Jayme Rutkoski on 7/4/23.
//  Copyright © 2023 truckyums. All rights reserved.
//

import Foundation

extension Double {
  func convert(from originalUnit: UnitLength, to convertedUnit: UnitLength) -> Double {
    return Measurement(value: self, unit: originalUnit).converted(to: convertedUnit).value
  }
}
