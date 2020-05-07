//
//  Cache+NetworkManager.swift
//  Alamofire
//
//  Created by WeiRuJian on 2020/5/7.
//

import Moya


public extension NetworkManager {
    
    public func removeAllCache() throws {
        try Storage<Response>().removeAll()
    }
    
    public func removeCache(target: TargetType) throws {
        try Storage<Response>().removeObject(forKey: target.cachedKey)
    }
    
}
