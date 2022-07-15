//
//  RepositorioModel.swift
//  desafio
//
//  Created by MARCOS FELIPE SOARES ROCHA on 15/12/21.
//
// Cada repositório deve exibir:
// - Nome do repositório
// - Descrição do Repositório
// - Nome / Foto do autor,
// - Número de Stars
// - Número de Forks

import Foundation

public struct Repositorios: Decodable {

    enum CodingKeys: String, CodingKey {
        case repositorio = "items"
    }

    var items: [Repositorio]

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        if let isItems = try? values.decode([Repositorio].self, forKey: .repositorio) {
            items = isItems
        } else {
            items = []
        }

        // items = try values.decode([Repositorio].self, forKey: .repositorio)
    }
}

public struct Repositorio: Decodable {

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case fullName = "full_name"
        case stargazersCount = "stargazers_count"
        case forksCount = "forks_count"
        case description = "description"
    }

    let nomeCompleto: String

    let nomeRepositorio: String
    var descricao: String = ""

    let nomeAutor: String
    let fotoAutor: String

    let estrelas: Int
    let forks: Int

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        nomeCompleto = try values.decode(String.self, forKey: .fullName)
        nomeRepositorio = try values.decode(String.self, forKey: .name)

        if let desc = try? values.decode(String.self, forKey: .description) {
            descricao = desc
        }

        nomeAutor = Repositorio.getNomeAutor(nome: nomeCompleto)
        fotoAutor = "\(String(describing: nomeAutor)).png"

        estrelas = try values.decode(Int.self, forKey: .stargazersCount)
        forks = try values.decode(Int.self, forKey: .forksCount)
    }

    private static func getNomeAutor(nome: String) -> String {
        var nomeAutor = nome
        if let dotRange = nomeAutor.range(of: "/") {
            nomeAutor.removeSubrange(dotRange.lowerBound..<nomeAutor.endIndex)
        }
        return nomeAutor
    }
}
