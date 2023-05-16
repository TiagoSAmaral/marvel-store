# Github Person

Aplicativo de laboratório. Ele consome a API do github para listar, buscar usuários. Também permite buscar dados somente de um usuário selecionado, e listar seus repositório, e também permite ver os dados do repositório.

Descricão simples:
- Tela lista usuários: 
    Permite buscar usuários.
- Tela dados usuário: 
    Expões alguns dados públicos do usuário selecionado
- Tela repositórios: 
    Lista os dados do repositório e permite veisualiza-lo pelo SafarieService dentro do app.

Suporte a Darkmode

## Preview

#### Light Mode
<p float="left">
    <img src="./readmeresource/list_users_l.png" width="160"/>
    <img src="./readmeresource/busca_result_l.png" width="160"/>
    <img src="./readmeresource/profile_l.png" width="160"/>
    <img src="./readmeresource/list_repo_l.png" width="160"/>
    <img src="./readmeresource/repo_detail_l.png" width="160"/>


#### Dark Mode
<p float="left">
    <img src="./readmeresource/list_users_d.png" width="160"/>
    <img src="./readmeresource/busca_result_d.png" width="160"/>
    <img src="./readmeresource/profile_d.png" width="160"/>
    <img src="./readmeresource/list_repo_d.png" width="160"/>
    <img src="./readmeresource/repo_detail_d.png" width="160"/>
</p>

## Sobre o projeto: <br>
- Xcode Version 14.2 ou superior<br>
- Suporte mínimo ao iOS 14<br>
- Swift 5<br>

## Preparando o Ambiente
Para executar o projeto, siga os passos abaixo.

#### Ferramentas de Gestão e Qualidade de Código<br>
- Fastlane
- Slather
- Jazzy
- Swiftlint

#### Gerenciador de Dependências<br>

Gerenciadores usados: 
 - Swift Package Manager

Dependências:
- [Kingfisher](https://github.com/onevcat/Kingfisher). Usando SPM (Download e cache de imagens).
- [Alamofire](https://github.com/Alamofire/Alamofire) Usando SPM (Realizaão de requisioes assincronas).


## Instruções para Execução de Projeto

Foi utilizado a versão do Ruby 2.7.0 no uso das ferramentas de gestão e qualidade.

---

## Configurando o Projeto

### [RVM](https://rvm.io/) e [BREW](https://brew.sh/)

Instale o RVM com o seguinte comando: <br>

```\curl -sSL https://get.rvm.io | bash -s stable```

Após a instalação, utilize o seguinte comando para usar a versão 2.7.0 do Ruby:

```
rvm install 2.7.0
```

Depois use o comando: <br>
```
rvm use 2.7.0
```

Instale o brew com o seguinte comando: <br>

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

---
### Instalando dependencias de Gestão

Após instalados o RVM com a versão indicada do Ruby, e a instalação do Brew, execute os seguintes comandos

```brew bundle```

Irá instalar as dependencias listadas no arquivo `Brewfile`.

Após a conclusão das instalaçoes feitas com brew, execute o comando a baixo para instalar as dependencias do Gemfile:

```bundle install```

---

### Instalação de Dependências do Projeto

No Xcode atualize as dependencias usando o Swift Package Manager

## Ferramentas

### Fastlane

Usado para automatizar tarefas como execucao de testes unitários, assinatura projetos e envio para Loja e Testflight.

No projeto, já possi alguns lanes básicos configurados. Para usa-los, execute um dos comandos abaixo:

- Check code style<br>
```fastlane ios lint_code```

- Create coverage report<br>
```fastlane ios coverage```

- Used by Development to keep code quality.<br>
```fastlane ios check_code``` ou ```fastlane check_code dev:true```

Ver mais no link: [Fastlane](https://fastlane.tools)

### Jazzy

Ferramenta para documentação de código

Ver mais no link: [Realm/jazzy](https://github.com/realm/jazzy)

### Slather

Ferramenta para exibir de forma mais amigável informações de cobertura de código do projeto.

Ver mais no link: [Slather](https://github.com/SlatherOrg/slather)