//
//  URLPathBuildable.swift
//  marvel-store
//
//  Created by Tiago Amaral on 01/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

protocol URLPathBuildable {
    func makeUrlWith(identifier: Int?, search titleValue: String?, filterSince year: Int?, startFrom Page: Int?) -> URL?
}
