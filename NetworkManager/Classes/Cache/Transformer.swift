//
//  Transformer.swift
//  Alamofire
//
//  Created by WeiRuJian on 2020/5/7.
//

import Foundation

public class Transformer<T> {
  let toData: (T) throws -> Data
  let fromData: (Data) throws -> T

  public init(toData: @escaping (T) throws -> Data, fromData: @escaping (Data) throws -> T) {
    self.toData = toData
    self.fromData = fromData
  }
}
