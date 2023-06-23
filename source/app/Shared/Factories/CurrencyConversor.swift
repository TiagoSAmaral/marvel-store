//
//  CurrencyConversor.swift
//  list-store
//
//  Created by Tiago Amaral on 05/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

enum CurrencyConversor {
    static func formatFrom(value: Double?) -> String? {
        guard let value = value else {
            return nil
        }
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        return formatter.string(from: value as NSNumber)
    }
}
