# Desafio iOS

## Criar um aplicativo para consultar a API do GitHub ##
Criar um aplicativo para consultar a API do GitHub e trazer os repositórios mais populares de Swift.

## O que será avaliado:
- Qualidade do código.
- Adoção de boas práticas recomendadas pela Apple no uso das APIs e Human Interface Guidelines.
- Funcionamento do produto entregue.

### Requisitos
- [X] Lista de repositórios. Exemplo de chamada na API : https://api.github.com/search/repositories?q=language:Swift&sort=stars&page=1    
- [ ] Paginação na tela de lista, com endless scroll / scroll infinito (incrementando o parâmetro page).    
- [X] Cada repositório deve exibir Nome do repositório, Descrição do Repositório, Nome / Foto do autor, Número de Stars, Número de Forks
- [X] Ao tocar em um item, deve levar a lista de Pull Requests do repositório

- [!]Pull Requests de um repositório. Exemplo de chamada na API: https://api.github.com/repos/<criador>/<repositório>/pulls
- [ ] Cada item da lista deve exibir:
    - [X] Nome
    - [ ] Foto do autor do PR
    - [X] Título do PR
    - [X] Data do PR
    - [X] Body do PR
- [X] Ao tocar em um item, deve abrir no browser a página do Pull Request em questão

### A solução DEVE conter
-    Versão mínima do iOS : 13.*
-    Arquivo .gitignore
-    Usar Viewcode
-    Gestão de dependências no projeto. Ex: Cocoapods
-    Framework para Comunicação com API. Ex: Alamofire
-    Mapeamento json -> Objeto . Ex: ObjectMapper
-    Cache de Imagens. Ex SDWebImage
-    Suporte devices a partir do iPhone 5s.
-    Desenvolvido em Swift 5+ e Xcode 13.1.

### **Ganha + pontos se conter** ###
-    Persistir os dados no CoreData
-    Exibir os dados do CoreData caso o app esteja offline
-    Testes unitários no projeto. Ex: XCTests
-    Componentes customizados;
-    Fonte customizadas;
-    l10n;
-    App Universal , Ipad | Iphone | Landscape | Portrait (Size Classes)

### **Ganha ++ pontos se usar** ###

-    SwiftUI com Combine.

### Sugestões ###
As sugestões de bibliotecas fornecidas são só um guideline, sintam-se a vontade para usar diferentes e nos surpreenderem. 
O importante de fato é que os objetivos macros sejam atingidos.

### Processo de submissão ###
O candidato deverá implementar a solução e enviar um pull request para este repositório com a solução.
O processo de Pull Request funciona da seguinte maneira:
1. Candidato fará um fork desse repositório (não irá clonar direto!)

2. Fará seu projeto nesse fork.

3. Commitará e subirá as alterações para o SEU fork.

4. Pela interface do GitHub, irá enviar um Pull Request.

Se possível deixar o fork público para facilitar a inspeção do código.

**ATENÇÃO**
Não se deve tentar fazer o PUSH diretamente para ESTE repositório!

# Pesquisa

## Alamofire

[Alamofire](https://github.com/Alamofire/Alamofire) é uma biblioteca de rede HTTP escrita em Swift.

Alamofire fornece uma interface elegante e combinável para solicitações de rede HTTP.
Ele não implementa sua própria funcionalidade de rede HTTP.
Em vez disso, ele se baseia no `URL Loading System` da Apple fornecido pela estrutura Foundation.
No núcleo do sistema estão `URLSession` e as subclasses `URLSessionTask`.
Alamofire envolve essas APIs, e muitas outras, em uma interface mais fácil de usar e fornece uma variedade de funcionalidades necessárias para o desenvolvimento de aplicativos modernos usando rede HTTP.
No entanto, é importante saber de onde vêm muitos dos principais comportamentos do Alamofire, portanto, familiarizar-se com o `URL Loading System` é importante.
Em última análise, os recursos de rede do Alamofire são limitados pelos recursos desse sistema e os comportamentos e práticas recomendadas devem ser sempre lembrados e observados.

Além disso, a rede no Alamofire (e no `URL Loading System` em geral) é feita de forma assíncrona.
A programação assíncrona pode ser uma fonte de frustração para os programadores não familiarizados com o conceito, mas existem boas razões para fazê-lo desta forma.
