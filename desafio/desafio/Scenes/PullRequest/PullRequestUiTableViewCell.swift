//
//  PullRequestUiTableViewCell.swift
//  desafio
//
//  Created by MARCOS FELIPE SOARES ROCHA on 16/12/21.
//

import UIKit

class PullRequestUiTableViewCell: UITableViewCell {

    private var stackView: UIStackView!
    private var autorStackView: UIStackView!
    public var url: String = ""

    private var fotoAutor: UIImageView = {
        let view = UIImageView()
        view.image = UIImage.init(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(weight: .light))
        view.contentMode = .scaleAspectFit
        return view
    }()

    private var nomeAutor: UILabel = {
        let view = PaddingLabel(withInsets: 0, 0, 0, 0)
        view.font = UIFont(name: "Montserrat-Bold", size: 24.0)
        view.numberOfLines = 1
        view.minimumScaleFactor = 0.5
        view.adjustsFontSizeToFitWidth = true
        view.layoutIfNeeded()
        view.textAlignment = .center

        view.backgroundColor = .black
        view.textColor = .white
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()

    private var titulo: UILabel = {
        let view = UILabel()
        view.text = "Título"
        view.font = UIFont(name: "Montserrat-Light", size: 42.0)
        view.numberOfLines = 1
        view.minimumScaleFactor = 0.5
        view.adjustsFontSizeToFitWidth = true
        view.layoutIfNeeded()
        view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        return view
    }()

    private var descricao: UILabel = {
        let view = UILabel()
        view.text = "Descrição"
        view.font = UIFont(name: "Montserrat-Regular", size: 14.0)
        view.numberOfLines = 0
        view.sizeToFit()
        view.layoutIfNeeded()
        return view
    }()

    private var data: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-Bold", size: 14.0)
        view.text = "Data"
        view.sizeToFit()
        view.layoutIfNeeded()
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white // UIColor(red: 235 / 255, green: 236 / 255, blue: 238 / 255, alpha: 1.0)
        // automaticallyUpdatesContentConfiguration = true
        layer.borderWidth = 1

        autorStackView = UIStackView(arrangedSubviews: [data, fotoAutor, nomeAutor])
        autorStackView.axis = .horizontal
        autorStackView.distribution = .fillEqually
        autorStackView.alignment = .firstBaseline
        autorStackView.spacing = 0.2

        stackView = UIStackView(arrangedSubviews: [titulo, autorStackView, descricao])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 1.0
        stackView.setCustomSpacing(4.0, after: descricao)
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 25, bottom: 5, right: 25)
        stackView.isLayoutMarginsRelativeArrangement = true

        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white// UIColor(red: 235 / 255, green: 236 / 255, blue: 238 / 255, alpha: 1.0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 18))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setData(pullRequest: PullRequest) {

        self.nomeAutor.text = pullRequest.autor.login
        // self.fotoAutor.image =
        self.titulo.text = pullRequest.titulo
        self.descricao.text = pullRequest.descricao
        self.data.text = formatDate(date: pullRequest.dataCriacao)
        self.url = pullRequest.link

    }

    func formatDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: date)!
        dateFormatter.dateFormat = "dd MMM, yyyy"
        return dateFormatter.string(from: date)
    }

}
