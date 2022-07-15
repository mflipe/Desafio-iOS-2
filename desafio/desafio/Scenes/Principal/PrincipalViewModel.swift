//
//  PrincipalViewModel.swift
//  desafio
//
//  Created by MARCOS FELIPE SOARES ROCHA on 15/12/21.
//

import Foundation

class PrincipalViewModel {

    var repositorios: [Repositorio] = []
    var coordinator: PrincipalCoordinator!

    let apiService: ApiService = ApiService.shared

    init() {}

    func proximaTela(repositorio: Repositorio) {
        coordinator.transitionToPullRequestView(repositorio: repositorio)
    }

}
