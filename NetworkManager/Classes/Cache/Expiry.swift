//
//  Expiry.swift
//  Alamofire
//
//  Created by WeiRuJian on 2020/5/7.
//  Copyright © 2020 WeiRuJian. All rights reserved.
//

import Foundation

public enum Expiry {
    /// Object will be expired in the nearest future
    case never
    /// Object will be expired in the specified amount of seconds
    case seconds(TimeInterval)
    /// Object will be expired on the specified date
    case date(Date)
    
    case expired
    
    /// Returns the appropriate date object
    public var date: Date {
        switch self {
        case .never:
            return .distantFuture
        case .seconds(let seconds):
            return Date().addingTimeInterval(seconds)
        case .date(let date):
            return date
        case .expired:
            return .distantPast
        }
    }
    
    /// Checks if cached object is expired according to expiration date
    public var isExpired: Bool {
        return timeInterval <= 0
    }
    
    var timeInterval: TimeInterval {
        switch self {
        case .never: return .infinity
        case let .seconds(secondes): return secondes
        case let .date(date): return date.timeIntervalSinceNow
        case .expired: return -(.infinity)
        }
    }

}
