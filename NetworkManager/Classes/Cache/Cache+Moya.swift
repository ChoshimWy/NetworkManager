//
//  Cache+Moya.swift
//  Alamofire
//
//  Created by WeiRuJian on 2020/5/6.
//

import Moya
import RxSwift

extension Reactive where Base: MoyaProviderType {
    
    public func onCache(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Observable<Response> {
        return Observable.create { observer in
            //读取缓存
            if let res = try? token.cachedResponse(token.cachedKey) {
                observer.onNext(res)
            }
            
            let cancellableToken = self.base.request(token, callbackQueue: callbackQueue, progress: nil, completion: { (result) in
                switch result {
                case let .success(response):
                    
                    observer.onNext(response)
                    do{
                        //新数据缓存
                        try token.saveCacheResponse(response)
                        observer.onCompleted()
                    } catch {
                        observer.onError(error)
                    }
                case let .failure(e):
                    observer.onError(e)
                }
            })
            return Disposables.create {
                cancellableToken.cancel()
            }
        }
    }
}

