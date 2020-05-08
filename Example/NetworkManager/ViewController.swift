//
//  ViewController.swift
//  NetworkManager
//
//  Created by WeiRuJian on 05/05/2020.
//  Copyright (c) 2020 WeiRuJian. All rights reserved.
//

import UIKit
import NetworkManager_Moya
import RxSwift
import Moya


class ViewController: UIViewController {
    
    private let dispose = DisposeBag()
    
    lazy var tableView: UITableView = {
        let tb = UITableView(frame: view.bounds)
        tb.delegate = self
        tb.dataSource = self
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tb
    }()
    
    var items: [List] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /// Using Plugins
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
        
        
//        NetworkManager.default.provider
//            .rx
//            .request(MultiTarget(Api.category))
//            .asObservable().distinctUntilChanged()
//            .map(BaseModel<ListData>.self)
//            .map {$0.data.list}
//            .subscribe(onNext: { (list) in
//                self.items = list
//                self.tableView.reloadData()
//            }, onError: { (e) in
//                print(e.localizedDescription)
//            }).disposed(by: dispose)
//
//        Api.category.request()
//            .map(BaseModel<ListData>.self)
//            .map { $0.data.list }
//            .subscribe(onSuccess: { (list) in
//                self.items = list
//                self.tableView.reloadData()
//            }) { (e) in
//                print(e.localizedDescription)
//        }.disposed(by: dispose)
//
//
//        /// Use Cache
//        NetworkManager.default.provider
//            .rx
//            .onCache(MultiTarget(Api.category))
//            .distinctUntilChanged()
//            .map(BaseModel<ListData>.self)
//            .map {$0.data.list}
//            .subscribe(onNext: { (list) in
//                self.items = list
//                self.tableView.reloadData()
//            }, onError: { (e) in
//                print(e.localizedDescription)
//            }).disposed(by: dispose)
//
//        Api.category.cache()
//            .distinctUntilChanged()
//            .map(BaseModel<ListData>.self)
//            .map { $0.data.list }
//            .subscribe(onNext: { (model) in
//                print(model.first?.name ?? "")
//                self.items = model
//                self.tableView.reloadData()
//            }, onError: { (e) in
//                print(e.localizedDescription)
//            }).disposed(by: dispose)
//
//
//
        
        
        view.addSubview(tableView)
        
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }
}

struct BaseModel<T: Codable>: Codable {
    var code: Int
    var data: T
}

struct ListData: Codable {
    let list: [List]
}

struct List: Codable {
    let name: String
    let icon: String
    let columnId: String
    let rankColumn: String
    let type: String
    let require: String
}
