//
//  ViewController.swift
//  ios-base-project
//
//  Created by Tiago Amaral on 23/01/20.
//  Copyright © 2020 Tiago Amaral. All rights reserved.
//

import UIKit

func localizedString(forKey: String) -> String {
     return Bundle.main.localizedString(forKey: forKey, value: nil, table: "Localizable-pt-BR")
}

class MainScreenView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        defineContraints(for: createLabelAlert())
    }
    
    func createLabelAlert() -> UILabel {
        let labelAlert: UILabel = UILabel()
        labelAlert.text = localizedString(forKey: LocalizedStaticString.messageReadme)
            //NSLocalizedString(LocalizedStaticString.messageReadme, comment: "")
        labelAlert.font.withSize(30.0)
        labelAlert.textColor = .red
        return labelAlert
    }
    
    func defineContraints(for alert: UILabel) {
        view.addSubview(alert)
        alert.translatesAutoresizingMaskIntoConstraints = false
        alert.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alert.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
