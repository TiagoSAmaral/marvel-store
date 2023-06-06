//
//  TableViewAutomaticPaginate.swift
//  marvel-store
//
//  Created by Tiago Amaral on 03/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

class TableViewAutomaticPaginate: UITableView, UITableViewDelegate, UITableViewDataSource, ListUpdateEvent {

    var dataHandler: ListDataHandler?
    var cardFactory: CardFactory?
    private var isPullToRefreshEnable = false
    private var isPaginateEnable = false
    private var propagateEvent: (() -> Void)?
    
    init(isPullToRefreshEnable: Bool = false, isPaginateEnable: Bool = false) {
        super.init(frame: .zero, style: .plain)
        self.isPullToRefreshEnable = isPullToRefreshEnable
        self.isPaginateEnable = isPaginateEnable
        defaultSetup()
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        defaultSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        defaultSetup()
    }

    private func defaultSetup() {
        delegate = self
        dataSource = self
        separatorStyle = .none
        separatorInset = .zero
        allowsSelection = false
        rowHeight = UITableView.automaticDimension
        registerEventScrollDidEnd()
        registerTableViewCell()
        makePullToRefresh()
    }
    
    func scrollingHasComeToEnd() {
        isPaginateEnable = false
        propagateEvent?()
    }
    
    func allowEmitScrollingHasComeToEnd() {
        isPaginateEnable = true
    }
    
    func register(event: (() -> Void)?) {
        propagateEvent = event
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > (scrollView.contentSize.height - (scrollView.frame.size.height + 400.0)) {
            if isPaginateEnable {
                scrollingHasComeToEnd()
            }
        }
    }
    
    func makePullToRefresh() {
        if isPullToRefreshEnable {
            let refreshControl = UIRefreshControl()
            refreshControl.attributedTitle = NSAttributedString(string: LocalizedText.with(tagName: .pullToRefreshText))
            refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
            self.refreshControl = refreshControl
        } else {
         refreshControl = nil
        }
    }
    
    @objc func refresh() {
        dataHandler?.updateContent()
    }
    
    func registerTableViewCell() {
        register(GenericTableViewCell.self, forCellReuseIdentifier: GenericTableViewCell.identifier)
    }
    
    func reloadView() {
        reloadData()
        refreshControl?.endRefreshing()
        allowEmitScrollingHasComeToEnd()
    }
    
    func registerEventScrollDidEnd() {
        register { [weak self] in
            self?.dataHandler?.nextPage()
        }
    }
    
// MARK: - UITableViewDataSource Implementation
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dataHandler?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataHandler?.numberOfItemsBy(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: GenericTableViewCell.identifier,
                                                       for: indexPath) as? GenericTableViewCell,
              let model = dataHandler?.dataBy(indexPath: indexPath) else {
            return UITableViewCell()
        }
        
        let card = cardFactory?.makeCard(from: model as? ViewModelBehavior)
        card?.defineLayout(with: cell.contentView)
        return cell
    }
    
    // MARK: YearFilterDelegate
    
    func receive(value: Int?) {
        dataHandler?.receiveFilter(value: value)
    }
}
