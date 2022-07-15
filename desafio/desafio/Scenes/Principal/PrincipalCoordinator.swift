//
//  PrincipalCoordinator.swift
//  desafio
//
//  Created by MARCOS FELIPE SOARES ROCHA on 15/12/21.
//

import Foundation

class PrincipalCoordinator: BaseCoordinator {
    var viewModel: PrincipalViewModel!

    override func start() {
        let viewController = PrincipalViewController()

        viewModel = PrincipalViewModel()
        viewModel.coordinator = self
        viewController.viewModel = viewModel

        navigationController.viewControllers = [viewController]
    }

    override func didFinish(coordinator: Coordinator) {
        super.didFinish(coordinator: coordinator)
    }

    func transitionToPullRequestView(repositorio: Repositorio) {
        let coordinator = PullRequestCoordinator(repositorio: repositorio)
        coordinator.navigationController = navigationController

        start(coordinator: coordinator)
    }

}
