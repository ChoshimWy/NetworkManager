//
//  Cache+TargetType.swift
//  Alamofire
//
//  Created by WeiRuJian on 2020/5/6.
//  Copyright © 2020 WeiRuJian. All rights reserved.
//

import Moya
import RxSwift

public extension TargetType {
    
    var cachedKey: String {
        if let request = try? endpoint.urlRequest(),
            let data = request.httpBody,
            let parameters = String(data: data, encoding: .utf8) {
            return "\(method.rawValue):\(endpoint.url)_\(parameters)"
        }
        return "\(method.rawValue):\(endpoint.url)"
    }
    
    private var endpoint: Endpoint {
        return Endpoint(url: URL(target: self).absoluteString,
                        sampleResponseClosure: { .networkResponse(200, self.sampleData) },
                        method: method,
                        task: task,
                        httpHeaderFields: headers)
    }
    
    func cachedResponse(_ key: String) throws -> Response {
        return try Storage<Response>().object(forKey: key)
    }
    
    func saveCacheResponse(_ response: Response) throws {
        return try Storage<Response>().setObject(response, forKey: self.cachedKey)
    }
    
    func removeCache() throws {
        try Storage<Response>().removeObject(forKey: cachedKey)
    }
    
    
    func cache() -> Observable<Moya.Response> {
        return NetworkManager.default.provider.rx.onCache(.target(self))
    }
}
