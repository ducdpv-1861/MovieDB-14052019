//
//  AppNavigator.swift
//  MovieDB
//
//  Created by tran.duc.tan on 5/14/19.
//  Copyright © 2019 tranductanb. All rights reserved.
//

import UIKit

protocol AppNavigatorType {
    func toMain()
}

struct AppNavigator: AppNavigatorType {
    unowned let assembler: Assembler
    unowned let window: UIWindow
    
    func toMain() {
        let mainViewController: MainViewController = assembler.resolve()
        let navi =  UINavigationController.init(rootViewController: mainViewController)
        window.rootViewController = navi
    }
}
