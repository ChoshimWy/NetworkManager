//
//  Cache+Response.swift
//  Alamofire
//
//  Created by WeiRuJian on 2020/5/6.
//  Copyright (c) 2020 WeiRuJian. All rights reserved.
//

import Moya


extension Storage where T == Response {
    
    convenience init(_ expiry: Expiry = .never) throws {
        try self.init(diskConfig: DiskConfig(name: "com.networkmanager.cache", expiry: expiry),
                      memoryConfig: MemoryConfig(expiry: expiry),
                      transformer: Transformer<T>(toData: { $0.data },
                                                  fromData: {T(statusCode: 200, data: $0)}))
    }
}



