//
//  AsyncStorage.swift
//  Alamofire
//
//  Created by WeiRuJian on 2020/5/7.
//  Copyright © 2020 WeiRuJian. All rights reserved.
//

import Foundation
import Dispatch

public class AsyncStorage<T> {
  public let innerStorage: HybridStorage<T>
  public let serialQueue: DispatchQueue

  public init(storage: HybridStorage<T>, serialQueue: DispatchQueue) {
    self.innerStorage = storage
    self.serialQueue = serialQueue
  }
}

extension AsyncStorage {
  public func entry(forKey key: String, completion: @escaping (StorageResult<Entry<T>>) -> Void) {
    serialQueue.async { [weak self] in
      guard let `self` = self else {
        completion(StorageResult.error(StorageError.deallocated))
        return
      }

      do {
        let anEntry = try self.innerStorage.entry(forKey: key)
        completion(StorageResult.value(anEntry))
      } catch {
        completion(StorageResult.error(error))
      }
    }
  }

  public func removeObject(forKey key: String, completion: @escaping (StorageResult<()>) -> Void) {
    serialQueue.async { [weak self] in
      guard let `self` = self else {
        completion(StorageResult.error(StorageError.deallocated))
        return
      }

      do {
        try self.innerStorage.removeObject(forKey: key)
        completion(StorageResult.value(()))
      } catch {
        completion(StorageResult.error(error))
      }
    }
  }

  public func setObject(
    _ object: T,
    forKey key: String,
    expiry: Expiry? = nil,
    completion: @escaping (StorageResult<()>) -> Void) {
    serialQueue.async { [weak self] in
      guard let `self` = self else {
        completion(StorageResult.error(StorageError.deallocated))
        return
      }

      do {
        try self.innerStorage.setObject(object, forKey: key, expiry: expiry)
        completion(StorageResult.value(()))
      } catch {
        completion(StorageResult.error(error))
      }
    }
  }

  public func removeAll(completion: @escaping (StorageResult<()>) -> Void) {
    serialQueue.async { [weak self] in
      guard let `self` = self else {
        completion(StorageResult.error(StorageError.deallocated))
        return
      }

      do {
        try self.innerStorage.removeAll()
        completion(StorageResult.value(()))
      } catch {
        completion(StorageResult.error(error))
      }
    }
  }

  public func removeExpiredObjects(completion: @escaping (StorageResult<()>) -> Void) {
    serialQueue.async { [weak self] in
      guard let `self` = self else {
        completion(StorageResult.error(StorageError.deallocated))
        return
      }

      do {
        try self.innerStorage.removeExpiredObjects()
        completion(StorageResult.value(()))
      } catch {
        completion(StorageResult.error(error))
      }
    }
  }

  public func object(forKey key: String, completion: @escaping (StorageResult<T>) -> Void) {
    entry(forKey: key, completion: { (result: StorageResult<Entry<T>>) in
      completion(result.map({ entry in
        return entry.object
      }))
    })
  }

  public func existsObject(
    forKey key: String,
    completion: @escaping (StorageResult<Bool>) -> Void) {
    object(forKey: key, completion: { (result: StorageResult<T>) in
      completion(result.map({ _ in
        return true
      }))
    })
  }
}

public extension AsyncStorage {
  func transform<U>(transformer: Transformer<U>) -> AsyncStorage<U> {
    let storage = AsyncStorage<U>(
      storage: innerStorage.transform(transformer: transformer),
      serialQueue: serialQueue
    )

    return storage
  }
}

