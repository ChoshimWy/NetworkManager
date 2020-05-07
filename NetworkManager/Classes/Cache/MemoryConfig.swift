//
//  MemoryConfig.swift
//  Alamofire
//
//  Created by WeiRuJian on 2020/5/7.
//  Copyright © 2020 WeiRuJian. All rights reserved.
//

import Foundation

public struct MemoryConfig {
  /// Expiry date that will be applied by default for every added object
  /// if it's not overridden in the add(key: object: expiry: completion:) method
  public let expiry: Expiry
  /// The maximum number of objects in memory the cache should hold.
  /// If 0, there is no count limit. The default value is 0.
  public let countLimit: UInt

  /// The maximum total cost that the cache can hold before it starts evicting objects.
  /// If 0, there is no total cost limit. The default value is 0
  public let totalCostLimit: UInt

  public init(expiry: Expiry = .never, countLimit: UInt = 0, totalCostLimit: UInt = 0) {
    self.expiry = expiry
    self.countLimit = countLimit
    self.totalCostLimit = totalCostLimit
  }
}
