//
//  MainCoordinator.swift
//  desafio
//
//  Created by MARCOS FELIPE SOARES ROCHA on 15/12/21.
//

import UIKit

class MainCoordinator: BaseCoordinator {

    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
    }

    override func start() {
        self.navigationController.navigationBar.isHidden = false

        let coordinator = PrincipalCoordinator()
        coordinator.navigationController = navigationController

        start(coordinator: coordinator)
    }
}
