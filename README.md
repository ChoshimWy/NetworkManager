# NetworkManager 0.1.0

[![CI Status](https://img.shields.io/travis/WeiRuJian/NetworkManager.svg?style=flat)](https://travis-ci.org/WeiRuJian/NetworkManager)
[![Version](https://img.shields.io/cocoapods/v/NetworkManager.svg?style=flat)](https://cocoapods.org/pods/NetworkManager)
[![License](https://img.shields.io/cocoapods/l/NetworkManager.svg?style=flat)](https://cocoapods.org/pods/NetworkManager)
[![Platform](https://img.shields.io/cocoapods/p/NetworkManager.svg?style=flat)](https://cocoapods.org/pods/NetworkManager)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
* iOS 10.0
* Swift 5.0
* Xcode 11

## Installation

NetworkManager is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'NetworkManager-Moya', '~> 0.1.0'

# or
pod 'NetworkManager-Moya/Cache', '~> 0.1.0'

```

## Usage

Do not use cache
```swift
NetworkManager.default.provider
    .rx
    .request(MultiTarget(Api.category))
    .asObservable().distinctUntilChanged()
    .map(BaseModel<ListData>.self)
    .map {$0.data.list}
    .subscribe(onNext: { (list) in
        self.items = list
        self.tableView.reloadData()
    }, onError: { (e) in
        print(e.localizedDescription)
    }).disposed(by: dispose)
```
Or you can use TargetType to request directly
```swift
Api.category.request()
    .map(BaseModel<ListData>.self)
    .map { $0.data.list }
    .subscribe(onSuccess: { (list) in
        self.items = list
        self.tableView.reloadData()
    }) { (e) in
        print(e.localizedDescription)
}.disposed(by: dispose)
```
Use cache
```swift
NetworkManager.default.provider
    .rx
    .onCache(MultiTarget(Api.category))
    .distinctUntilChanged()
    .map(BaseModel<ListData>.self)
    .map {$0.data.list}
    .subscribe(onNext: { (list) in
        self.items = list
        self.tableView.reloadData()
    }, onError: { (e) in
        print(e.localizedDescription)
    }).disposed(by: dispose)
    
/// or

Api.category.cache()
    .distinctUntilChanged()
    .map(BaseModel<ListData>.self)
    .map { $0.data.list }
    .subscribe(onNext: { (model) in
        print(model.first?.name ?? "")
        self.items = model
        self.tableView.reloadData()
    }, onError: { (e) in
        print(e.localizedDescription)
    }).disposed(by: dispose)
```
You can also customize the use of the plugin
```swift
let configuration = Configuration()
configuration.plugins.append(LoggingPlugin())
let manager = NetworkManager(configuration: configuration)
manager.provider
    .rx
    .request(MultiTarget(Api.category))
    .asObservable().distinctUntilChanged()
    .map(BaseModel<ListData>.self)
    .map {$0.data.list}
    .subscribe(onNext: { (list) in
        self.items = list
        self.tableView.reloadData()
    }, onError: { (e) in
        print(e.localizedDescription)
    }).disposed(by: dispose)
```

## Author

WeiRuJian, 824041965@qq.com

## License

NetworkManager is available under the MIT license. See the LICENSE file for more info.
