//
//  PrincipalViewController.swift
//  desafio
//
//  Created by MARCOS FELIPE SOARES ROCHA on 15/12/21.
//

import UIKit

class PrincipalViewController: UITableViewController {

    var viewModel: PrincipalViewModel!
    let cellSpacingHeight: CGFloat = 5

    private lazy var _tableView: UITableView? = {
        let view = UITableView(frame: .zero)
        return view
    }()

    var paginaAtual = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(PrincipalTableViewCell.self, forCellReuseIdentifier: "thisTable")

        view.backgroundColor = UIColor.white

        view.addSubview(_tableView!)

        viewModel.apiService.getRepositorios(page: paginaAtual) { [weak self] result in
            switch result {
            case .success(let response):
                self?.viewModel.repositorios = response.items
                self?.tableView.reloadData()

            default:
                self?.viewModel.repositorios = []
            }
        }

        tableView.reloadData()
    }

    /*
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .red
        return headerView
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .blue
        return footerView
    }
     */

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.repositorios.count
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "thisTable", for: indexPath)
            as? PrincipalTableViewCell {
            cell.setData(repositorio: self.viewModel.repositorios[indexPath.section])
            return cell
        }

        return PrincipalTableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.section).")
        let repo = self.viewModel.repositorios[indexPath.section]
        viewModel.proximaTela(repositorio: repo)
    }

    override open func tableView(
        _ tableView: UITableView,
        willDisplay cell: UITableViewCell,
        forRowAt indexPath: IndexPath
    ) {
        if indexPath.section == self.viewModel.repositorios.count - 10 {
            if self.paginaAtual >= 10 {
                self.paginaAtual = 1
            }
            viewModel.apiService.getRepositorios(page: paginaAtual) { [weak self] result in
                switch result {
                case .success(let response):
                    if (self?.viewModel.repositorios.count)! < 150 {
                        self?.viewModel.repositorios += response.items
                    } else {
                        self?.viewModel.repositorios = response.items
                    }
                    self?.paginaAtual += 1
                    self?.tableView.reloadData()

                default:
                    self?.viewModel.repositorios = []
                }
            }
        }
    }

}
