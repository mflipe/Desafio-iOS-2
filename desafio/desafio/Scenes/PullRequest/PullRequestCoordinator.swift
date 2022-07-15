//
//  PullRequestCoordinator.swift
//  desafio
//
//  Created by MARCOS FELIPE SOARES ROCHA on 16/12/21.
//

import Foundation

class PullRequestCoordinator: BaseCoordinator {

    var viewModel: PullRequestViewModel!
    var currentRepositorio: Repositorio?

    internal init(repositorio: Repositorio? = nil) {
        super.init()
        self.currentRepositorio = repositorio
    }

    override func start() {
        let viewController = PullRequestViewController(repositorio: self.currentRepositorio)

        viewModel = PullRequestViewModel()
        viewController.viewModel = viewModel

        navigationController.pushViewController(viewController, animated: true)
    }

    override func didFinish(coordinator: Coordinator) {
        super.didFinish(coordinator: coordinator)
    }

}
