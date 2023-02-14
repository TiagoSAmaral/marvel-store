//
//  ViewController.swift
//  ios-base-project
//
//  Created on 23/01/20.
//

import UIKit

class MainScreenView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        defineContraints(for: createLabelAlert())
    }
    
    func createLabelAlert() -> UILabel {
        let labelAlert: UILabel = UILabel()
        labelAlert.text = LocalizedText.with(tagName: .messageReadme)
        labelAlert.font.withSize(30.0)
        labelAlert.textColor = .red
        labelAlert.numberOfLines = 0
        labelAlert.textAlignment = .center
        return labelAlert
    }
    
    func defineContraints(for alert: UILabel) {
        view.addSubview(alert)
        alert.translatesAutoresizingMaskIntoConstraints = false
        alert.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alert.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
