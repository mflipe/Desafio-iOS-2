//
//  PullRequestViewController.swift
//  desafio
//
//  Created by MARCOS FELIPE SOARES ROCHA on 16/12/21.
//

import UIKit

class PullRequestViewController: UITableViewController {

    var viewModel: PullRequestViewModel!
    let cellSpacingHeight: CGFloat = 0
    var currentRepositorio: Repositorio?

    public init(repositorio: Repositorio? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.currentRepositorio = repositorio
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var _tableView: UITableView? = {
        let view = UITableView(frame: .zero)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(PullRequestUiTableViewCell.self, forCellReuseIdentifier: "PRTable")

        view.backgroundColor = .white

        view.addSubview(_tableView!)

        let autor = currentRepositorio?.nomeAutor
        let repo = currentRepositorio?.nomeRepositorio

        viewModel.apiService.getPullRequests(
            autor: autor!,
            repositorio: repo!
        ) { [weak self] result in
            switch result {
            case .success(let response):
                self?.viewModel.pullRequests = response.pullRequests
                self?.tableView.reloadData()

            default:
                self?.viewModel.pullRequests = []
            }
        }
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.pullRequests.count
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "PRTable", for: indexPath)
            as? PullRequestUiTableViewCell {
            cell.setData(pullRequest: self.viewModel.pullRequests[indexPath.section])
            return cell
        }

        return PullRequestUiTableViewCell()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.section).")

        if let cell = tableView.cellForRow(at: indexPath) as? PullRequestUiTableViewCell {
            if let link = URL( string: cell.url ) {
                UIApplication.shared.open(link)
            }
        }
    }

}
