//
//  Configuration.swift
//  Alamofire
//
//  Created by WeiRuJian on 2020/5/6.
//  Copyright (c) 2020 WeiRuJian. All rights reserved.
//

import Moya

public class Configuration {
    public static let `default` = Configuration()
    

    public var plugins: [PluginType] = []
    
    public var timeoutInterval: TimeInterval = 60
    
    public var httpShouldHandleCookies = false
    
    private let activityPlugin = NetworkActivityPlugin { (change, _) in
        switch (change) {
        case .began:
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            }
        case .ended:
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    public init() {
        plugins = [activityPlugin]
    }
}
