//
//  TableViewAutomaticPaginate.swift
//  marvel-store
//
//  Created by Tiago Amaral on 03/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

class TableViewAutomaticPaginate: UITableView, UITableViewDelegate {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        defaultSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        defaultSetup()
    }
    
    private var isAllowEmitScrollingHasComeToEnt: Bool = true
    
    private var propagateEvent: (() -> Void)?
    
    private func defaultSetup() {
        delegate = self
        separatorStyle = .none
        separatorInset = .zero
        allowsSelection = false
        rowHeight = UITableView.automaticDimension
    }
    
    
    func scrollingHasComeToEnd() {
        isAllowEmitScrollingHasComeToEnt = false
        propagateEvent?()
    }
    
    func allowEmitScrollingHasComeToEnd() {
        isAllowEmitScrollingHasComeToEnt = true
    }
    
    func register(event: (() -> Void)?) {
        propagateEvent = event
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height) {
            if isAllowEmitScrollingHasComeToEnt {
                scrollingHasComeToEnd()
            }
        }
    }
}
