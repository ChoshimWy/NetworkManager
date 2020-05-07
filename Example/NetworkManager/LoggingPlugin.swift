//
//  LoggingPlugin.swift
//  NetworkManager_Example
//
//  Created by WeiRuJian on 2020/5/7.
//  Copyright © 2020 Choshim丶Wy. All rights reserved.
//

import Foundation
import Moya
import SwiftyBeaver


let Log = SwiftyBeaver.self

class LoggingPlugin: PluginType {
    
    func willSend(_ request: RequestType, target: TargetType) {
        //        let headers = request.request?.allHTTPHeaderFields ?? [:]
        //        let url = request.request?.url?.absoluteString ?? ""
        //        if let body = request.request?.httpBody {
        //            let bodyStr = String(bytes: body, encoding: .utf8) ?? ""
        //            Log.debug(
        //                """
        //                    url: \(url)
        //                    headers : \(headers)
        //                    body: \(bodyStr)
        //                """
        //            )
        //        } else {
        //            Log.debug(
        //                """
        //                    url: \(url)
        //                    headers : \(headers)
        //                    body: nil
        //                """
        //            )
        //        }
        
        Log.debug(request.request?.url?.absoluteString ?? "")
    }
    
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        
        //        var respon: Response?
        //        var error: MoyaError?
        switch result {
        case let .success(response):
            do {
                let json = try JSONSerialization.jsonObject(with: response.data, options: .allowFragments)
                Log.info(json)
            } catch {
                if let string = String(bytes: response.data, encoding: .utf8) {
                    Log.debug(string)
                } else {
                    Log.error("response empty")
                }
            }
        case let .failure(e):
            Log.error(e)
        }
        
        //        let request = respon?.request
        //        let url = request?.url?.absoluteString ?? "nil"
        //        let method = request?.httpMethod ?? "nil"
        //        let statusCode = respon?.statusCode ?? 0
        //        var responseStr = "nil"
        //        if let data = respon?.data, let string = String(bytes: data, encoding: .utf8) {
        //            responseStr = string
        //        }
        //
        //        Log.debug(responseStr)
        
        //        Log.debug(
        //            """
        //                <didReceive - \(method) statusCode: \(statusCode)>
        //                url: \(url)
        //                error: \(error?.localizedDescription ?? "nil")
        //                response: \(responseStr)
        //            """
        //        )
    }
}
