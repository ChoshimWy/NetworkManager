//
//  MoyaProvider+Extension.swift
//  Alamofire
//
//  Created by WeiRuJian on 2020/5/6.
//  Copyright (c) 2020 WeiRuJian. All rights reserved.
//

import Moya

public extension MoyaProvider {
    
    convenience init(config: Configuration) {
        
        let endpointClosure: EndpointClosure = { target -> Endpoint in
            let url = target.baseURL.absoluteString + target.path
            return Endpoint(url: url,
                            sampleResponseClosure: {.networkResponse(200, target.sampleData) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        
        let requestClosure =  { (endpoint: Endpoint, closure: RequestResultClosure) -> Void in
            do {
                var request = try endpoint.urlRequest()
                request.timeoutInterval = config.timeoutInterval
                request.httpShouldHandleCookies = config.httpShouldHandleCookies
                closure(.success(request))
            } catch MoyaError.requestMapping(let url) {
                closure(.failure(.requestMapping(url)))
            } catch MoyaError.parameterEncoding(let error) {
                closure(.failure(.parameterEncoding(error)))
            } catch {
                closure(.failure(.underlying(error, nil)))
            }
        }
        
        self.init(endpointClosure: endpointClosure,
                  requestClosure: requestClosure,
                  plugins: config.plugins)
    }
}
