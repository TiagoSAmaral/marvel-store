//
//  ViewFactory.swift
//  marvel-store
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

protocol Controller: AnyObject {
    var view: UIView! { get set }
    var dataHandler: ListDataHandler? { get }
}

protocol ListFactory {
    func reloadView()
    func defineViewInController()
}

protocol YearFilterDataHandler {
    func receive(value: Int?)
}

class ListFactoryView: NSObject, ListFactory, YearSelectorViewDelegate, UITableViewDataSource {
        
    weak var controller: Controller?
    var cardFactory: CardFactory?
    var refreshControl: UIRefreshControl?
    private var tableView: TableViewAutomaticPaginate?
    private var filterYearView: YearSelectorView?
    
    init(controller: Controller? = nil) {
        super.init()
        self.controller = controller
    }
    
    func defineViewInController() {
        makeTableView()
        setupTableView()
        registerTableViewCell()
        makePullToRefresh()
        makeFilterView()
        makeView()
    }
    
    func makeView() {
        guard let controller = controller,
              let tableView = tableView else {
            return
        }
        controller.view.addSubviews([tableView]) //addSubview(tableView)
//        tableView.edgeToSuperView()
        tableView.trailingToSuperview().leadingToSuperview().bottomToSuperview().topToSuperview(margin: 44)
    }
    
    func makeTableView() {
        guard tableView == nil else {
            return
        }
        tableView = TableViewAutomaticPaginate(frame: .zero, style: .plain)
    }
    
    func makeFilterView() {
        
        guard let controller = controller else {
            return
        }
        
        filterYearView = YearSelectorView()
        filterYearView?.injectAtView(at: controller.view)
        filterYearView?.define(delegate: self)
    }
    
    func makePullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: LocalizedText.with(tagName: .pullToRefreshText))
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
       tableView?.addSubview(refreshControl) // not required when using UITableViewController
        self.refreshControl = refreshControl
    }
    
    @objc func refresh() {
        controller?.dataHandler?.updateContent()
    }
    
    func setupTableView() {
        makeTableView()
        tableView?.dataSource = self
        registerEventScrollDidEnd()
    }
    
    func registerTableViewCell() {
        tableView?.register(GenericTableViewCell.self, forCellReuseIdentifier: GenericTableViewCell.identifier)
    }
    
    func reloadView() {
        tableView?.reloadData()
        refreshControl?.endRefreshing()
        tableView?.allowEmitScrollingHasComeToEnd()
    }
    
    func registerEventScrollDidEnd() {
        tableView?.register() { [weak self] in
            self?.controller?.dataHandler?.nextPage()
        }
    }

// MARK: - UITableViewDataSource Implementation
    
    func numberOfSections(in tableView: UITableView) -> Int {
        controller?.dataHandler?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        controller?.dataHandler?.numberOfItemsBy(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: GenericTableViewCell.identifier,
                                                       for: indexPath) as? GenericTableViewCell,
              let model = controller?.dataHandler?.dataBy(indexPath: indexPath) else {
            return UITableViewCell()
        }
        
        let card = cardFactory?.makeCard(from: model as? ViewModelBehavior)
        card?.defineLayout(with: cell.contentView)
        return cell
    }
    
    // MARK: YearFilterDelegate
    
    func receive(value: Int?) {
        controller?.dataHandler?.receiveFilter(value: value)
    }
}
