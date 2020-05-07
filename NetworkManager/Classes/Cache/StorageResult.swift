//
//  StorageResult.swift
//  Alamofire
//
//  Created by WeiRuJian on 2020/5/7.
//

import Foundation

public enum StorageResult<T> {
  case value(T)
  case error(Error)

  public func map<U>(_ transform: (T) -> U) -> StorageResult<U> {
    switch self {
    case .value(let value):
      return StorageResult<U>.value(transform(value))
    case .error(let error):
      return StorageResult<U>.error(error)
    }
  }
}
