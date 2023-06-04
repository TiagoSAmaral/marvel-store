//
//  DatePicker.swift
//  marvel-store
//
//  Created by Tiago Amaral on 03/06/23.
//  Copyright © 2023 developer_organization_name. All rights reserved.
//

import Foundation

//  PDPicker.swift
//  Created by Tiago da Silva Amaral on 28/11/17.
//  Copyright © 2017 Valid S.A. All rights reserved.
//

import UIKit

typealias ResponsePicker = (_ picker: PDPicker, _ data: OptionsPickerView, _ row: Int) -> Void

final class PDPicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    fileprivate var pickerOptions: [OptionsPickerView]?
    fileprivate var response: ResponsePicker?
    private var toolBar: UIToolbar?
    
    init(options: [OptionsPickerView], response: @escaping ResponsePicker) {
        super.init(frame: CGRect(x: 0,
                                 y: UIScreen.main.bounds.size.height - 300,
                                 width: UIScreen.main.bounds.size.width,
                                 height: 300))
        delegate = self
        dataSource = self
        pickerOptions = options
        self.response = response
        defineLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func defineLayout() {
        setValue(ColorAsset.cardBackgroundColor, forKey: "backgroundColor")
    }
    
    // Exposed method
    func showPicker(at view: UIView) {
        presentPickerView(at: view)
        makeToolBar(at: view)
    }
    
    private func presentPickerView(at view: UIView) {
        view.addSubview(self)
    }
    
    private func makeToolBar(at view: UIView) {
        
        let toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .black
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.toolBar = toolBar
        view.addSubview(toolBar)
        view.bringSubviewToFront(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        toolBar?.removeFromSuperview()
        removeFromSuperview()
    }
    
    // DataSource and Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
        guard let options = pickerOptions else {
            return .zero
        }
    
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        guard let options = pickerOptions else {
            return String()
        }
        
        return options[row].label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        guard let options = pickerOptions else {
            return
        }
        response?(self, options[row], row)
    }
}

struct OptionsPickerView {
    let label: String
    let data: String
}
