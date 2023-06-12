//
//  FavoritesFactoryPage.swift
//  marvel-store
//
//  Created by Tiago Amaral on 04/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import UIKit

class ListFavoritePageFactory: FactoryPage {
   
    static func makePage(coordinator: Coordinator?, model: Model?) -> UIViewController? {
        let controller = ListContentPageController()
        let viewModel = ListContentPageViewModel()
        let mosaicComposerView = ViewMosaicComposer()
        let listView = TableViewAutomaticPaginate()
        let cardMaker = CardMaker()
        
        viewModel.controller = controller
        viewModel.coordinator = coordinator as? ListContentPageCoordinator
        viewModel.currentViewModelStrategy = .favorite
        
        listView.dataHandler = viewModel
        listView.cardFactory = cardMaker
        mosaicComposerView.insertNew(view: listView)
        
        coordinator?.rootViewControler = controller
        
        controller.listView = listView
        controller.viewModel = viewModel
        controller.viewDidAppearEvent = viewModel.loadFavoritesItems
        controller.coordinator = coordinator as? ListContentCoordinable
        controller.title = LocalizedText.with(tagName: .favoriteTitle)
        controller.view = mosaicComposerView.baseView
        return controller
    }
}
