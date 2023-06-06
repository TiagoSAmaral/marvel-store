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
        let viewModel = ListContentPageViewModel(controller: controller,
                                               network: nil,
                                               coordinator: coordinator)
        viewModel.currentViewModelStrategy = .favorite
        let mosaicComposerView = ViewMosaicComposer()
        
        let listView = TableViewAutomaticPaginate()
        listView.dataHandler = viewModel
        listView.cardFactory = CardMaker()
        mosaicComposerView.insertNew(view: listView)
        controller.listView = listView
        
        coordinator?.rootViewControler = controller
        controller.viewModel = viewModel
        controller.viewDidAppearEvent = viewModel.loadFavoritesItems
        controller.coordinator = coordinator as? ListContentCoordinable
        controller.title = LocalizedText.with(tagName: .favoriteTitle)
        controller.view = mosaicComposerView.baseView
        return controller
    }
}
