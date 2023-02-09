//
//  TicketViewController.swift
//  KinoKz
//
//  Created by Aknar Assanov on 02.02.2023.
//

import UIKit

class TicketViewController: UIViewController {

    let view2:UIView = PlaceHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = .systemGreen
        
        view.addSubview(view2)
        view2.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
