//
//  NetworkManager.swift
//  FBSnapshotTestCase
//
//  Created by WeiRuJian on 05/05/2020.
//  Copyright (c) 2020 WeiRuJian. All rights reserved.
//

import Moya

public class NetworkManager {
    
    public static let `default` = NetworkManager(configuration: .default)
    
    public var provider: MoyaProvider<MultiTarget>
    
    public init(configuration: Configuration) {
        self.provider = MoyaProvider(config: configuration)
    }
    
}


