//
//  PrincipalUiTableViewCell.swift
//  desafio
//
//  Created by MARCOS FELIPE SOARES ROCHA on 16/12/21.
//

import UIKit

class PrincipalTableViewCell: UITableViewCell {

    private var stackView: UIStackView!
    private var autorStackView: UIStackView!

    private var starForkStackView: UIStackView!

    private var nomeRepositorio: UILabel = {
        let view = UILabel()
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
        view.sizeToFit()
        return view
    }()

    private var descricaoTitle: UILabel = {
        let view = UILabel()
        view.text = "Descrição"
        view.font = UIFont(name: "Montserrat-Medium", size: 28.0)
        view.numberOfLines = 1
        view.minimumScaleFactor = 0.5
        view.adjustsFontSizeToFitWidth = true
        view.layoutIfNeeded()
        return view
    }()

    private var descricao: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-Regular", size: 14.0)
        view.numberOfLines = 0
        view.sizeToFit()
        view.layoutIfNeeded()
        return view
    }()

    private var estrelas: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-Regular", size: 14.0)
        view.sizeToFit()
        view.layoutIfNeeded()
        view.textAlignment = .left
        return view
    }()

    private var forks: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "Montserrat-Regular", size: 14.0)
        view.sizeToFit()
        view.layoutIfNeeded()
        view.textAlignment = .left
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // backgroundColor = UIColor(red: 235 / 255, green: 236 / 255, blue: 238 / 255, alpha: 1.0)
        // automaticallyUpdatesContentConfiguration = true
        // layer.borderWidth = 1

        autorStackView = UIStackView(arrangedSubviews: [estrelas, forks, nomeAutor, fotoAutor])
        autorStackView.axis = .horizontal
        autorStackView.distribution = .fillEqually
        autorStackView.alignment = .firstBaseline
        autorStackView.spacing = 0.2

        stackView = UIStackView(arrangedSubviews: [nomeRepositorio, descricao, autorStackView])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 2.0
        stackView.setCustomSpacing(4.0, after: descricao)
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setData(repositorio: Repositorio) {

        self.nomeAutor.text = repositorio.nomeAutor
        self.nomeRepositorio.text = repositorio.nomeRepositorio
        if  repositorio.descricao != "" {
            self.descricao.text = repositorio.descricao
        } else {
            self.descricao.text = "\n"
        }
        self.estrelas.text = "⭐️ \(repositorio.estrelas)"
        self.forks.text = "🔧 \(repositorio.forks)"
//        self.fotoAutor.image = repositorio.fotoAutor

    }

}

class PaddingLabel: UILabel {

    var topInset: CGFloat
    var bottomInset: CGFloat
    var leftInset: CGFloat
    var rightInset: CGFloat

    required init(withInsets top: CGFloat, _ bottom: CGFloat, _ left: CGFloat, _ right: CGFloat) {
        self.topInset = top
        self.bottomInset = bottom
        self.leftInset = left
        self.rightInset = right
        super.init(frame: CGRect.zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
}
