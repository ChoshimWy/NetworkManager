//
//  TargetType+Rx.swift
//  Alamofire
//
//  Created by WeiRuJian on 2020/5/7.
//

import Moya
import RxSwift

public extension TargetType {
    
    func request() -> Single<Moya.Response> {
        return NetworkManager.default.provider.rx.request(.target(self))
    }
}
