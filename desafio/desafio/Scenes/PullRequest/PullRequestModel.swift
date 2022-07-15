//
//  PullRequestModel.swift
//  desafio
//
//  Created by MARCOS FELIPE SOARES ROCHA on 16/12/21.
//

import Foundation

public struct PullRequests: Decodable {

    var pullRequests: [PullRequest]

    public init(from decoder: Decoder) throws {
        let values = try decoder.singleValueContainer()
        pullRequests = try values.decode([PullRequest].self)
    }
}

public struct PullRequest: Decodable {

    enum CodingKeys: String, CodingKey {
        case titulo = "title"
        case link = "html_url"
        case descricao = "body"
        case estado = "state"
        case dataCriacao = "created_at"
        case dataUpdate = "updated_at"
        case isClosed = "closed_at"
        case isMerged = "merged_at"
        case autor = "user"
        case repositorio = "repo"
        case repoHead = "head"
    }

    let autor: User
    // let repositorio: Repositorio

    let titulo: String
    let link: String
    var descricao: String = ""
    let estado: String
    let dataCriacao: String
    let dataUpdate: String
    // let isClosed: String?
    // let isMerged: String?

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        autor = try values.decode(User.self, forKey: .autor)

        titulo = try values.decode(String.self, forKey: .titulo)
        link = try values.decode(String.self, forKey: .link)

        if let desc = try? values.decode(String.self, forKey: .descricao) {
            descricao = desc
        }

        estado = try values.decode(String.self, forKey: .estado)

        dataCriacao = try values.decode(String.self, forKey: .dataCriacao)
        dataUpdate = try values.decode(String.self, forKey: .dataUpdate)
        // isClosed = try values.decode(String.self, forKey: .isClosed)
        // isMerged = try values.decode(String.self, forKey: .isMerged)
    }
}

public struct User: Decodable {

    enum CodingKeys: String, CodingKey {
        case nomeAutor = "login"
        case fotoAutor = "avatar_url"
    }

    let login: String
    let avatarURL: String

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        login = try values.decode(String.self, forKey: .nomeAutor)
        avatarURL = try values.decode(String.self, forKey: .fotoAutor)
    }
}
