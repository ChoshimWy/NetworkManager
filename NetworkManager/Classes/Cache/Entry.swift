//
//  Entry.swift
//  Alamofire
//
//  Created by WeiRuJian on 2020/5/7.
//

import Foundation

public struct Entry<T> {
  /// Cached object
  public let object: T
  /// Expiry date
  public let expiry: Expiry
  /// File path to the cached object
  public let filePath: String?

  init(object: T, expiry: Expiry, filePath: String? = nil) {
    self.object = object
    self.expiry = expiry
    self.filePath = filePath
  }
}
