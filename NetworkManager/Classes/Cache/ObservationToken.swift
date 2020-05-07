//
//  ObservationToken.swift
//  Alamofire
//
//  Created by WeiRuJian on 2020/5/7.
//

import Foundation

public final class ObservationToken {
  private let cancellationClosure: () -> Void

  init(cancellationClosure: @escaping () -> Void) {
    self.cancellationClosure = cancellationClosure
  }

  public func cancel() {
    cancellationClosure()
  }
}
