//
//  Collection+Extension.swift
//  TheSportsDB
//
//  Created by Quentin Gallois on 30/08/2020.
//  Copyright © 2020 Quentin Gallois. All rights reserved.
//

import Foundation

struct SafeCollection<Base: Collection> {

  private var base: Base

  init(_ base: Base) {
    self.base = base
  }

  private func distance(from startIndex: Base.Index) -> Int {
    base.distance(from: startIndex, to: base.endIndex)
  }

  private func distance(to endIndex: Base.Index) -> Int {
    base.distance(from: base.startIndex, to: endIndex)
  }

  subscript(index: Base.Index) -> Base.Iterator.Element? {
    if distance(to: index) >= 0, distance(from: index) > 0 {
      return base[index]
    }
    return nil
  }

  subscript(bounds: Range<Base.Index>) -> Base.SubSequence? {
    if distance(to: bounds.lowerBound) >= 0, distance(from: bounds.upperBound) >= 0 {
      return base[bounds]
    }
    return nil
  }

  subscript(bounds: ClosedRange<Base.Index>) -> Base.SubSequence? {
    if distance(to: bounds.lowerBound) >= 0, distance(from: bounds.upperBound) > 0 {
      return base[bounds]
    }
    return nil
  }
}

extension Collection {
  var safe: SafeCollection<Self> {
    SafeCollection(self)
  }
}
