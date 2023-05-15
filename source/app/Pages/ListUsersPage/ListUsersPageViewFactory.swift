//
//  ViewFactory.swift
//  github-person
//
//  Created by Tiago Amaral on 13/05/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

protocol ViewFactory {
    var controller: ListUserController? { get }
    func reloadView()
}

protocol ListDataHandler {
    func updateContent()
    func numberOfItemsBy(section: Int?) -> Int
    func numberOfSections() -> Int
    func dataBy(indexPath: IndexPath) -> Model?
}

class ListUserPageViewFactory: NSObject, ViewFactory, UITableViewDataSource {
        
    weak var controller: ListUserController?
    var viewModel: ListDataHandler?
    var cardFactory: CardFactory?
    var refreshControl: UIRefreshControl?
    private var tableView: UITableView?
    
    init(controller: ListUserController? = nil) {
        super.init()
        self.controller = controller
        makeTableView()
        setupTableView()
        registerTableViewCell()
        makePullToRefresh()
        makeView()
    }
    
    func makeView() {
        guard let controller = controller,
              let tableView = tableView else {
            return
        }
        controller.view.addSubview(tableView)
        
        tableView.edgeToSuperView()
    }
    
    func makeTableView() {
        guard tableView == nil else {
            return
        }
        tableView = UITableView(frame: .zero, style: .plain)
    }
    
    func makePullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: LocalizedText.with(tagName: .pullToRefreshText))
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
       tableView?.addSubview(refreshControl) // not required when using UITableViewController
        self.refreshControl = refreshControl
    }
    
    @objc func refresh() {
        viewModel?.updateContent()
        refreshControl?.endRefreshing()
    }
    
    func setupTableView() {
        makeTableView()
        tableView?.dataSource = self
        tableView?.separatorStyle = .none
        tableView?.separatorInset = .zero
        tableView?.allowsSelection = false
        tableView?.rowHeight = UITableView.automaticDimension
    }
    
    func registerTableViewCell() {
        tableView?.register(GenericTableViewCell.self, forCellReuseIdentifier: GenericTableViewCell.identifier)
    }
    
    func reloadView() {
        tableView?.reloadData()
    }

// MARK: - UITableViewDataSource Implementation
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfItemsBy(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: GenericTableViewCell.identifier,
                                                       for: indexPath) as? GenericTableViewCell,
                let model = viewModel?.dataBy(indexPath: indexPath) else {
            return UITableViewCell()
        }
        
        let card = cardFactory?.makeCard(from: model)
        card?.defineLayout(with: cell.contentView)
        return cell
        
    }
}
