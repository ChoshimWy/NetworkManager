//
//  MemoryCapsule.swift
//  Alamofire
//
//  Created by WeiRuJian on 2020/5/7.
//

import Foundation

class MemoryCapsule: NSObject {
  /// Object to be cached
  let object: Any
  /// Expiration date
  let expiry: Expiry

  /**
   Creates a new instance of Capsule.
   - Parameter value: Object to be cached
   - Parameter expiry: Expiration date
   */
  init(value: Any, expiry: Expiry) {
    self.object = value
    self.expiry = expiry
  }
}
