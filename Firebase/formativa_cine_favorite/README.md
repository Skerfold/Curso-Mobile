# Cine Favorite ( Formativa )

Construir um aplicativo do 0 - O CineFavorite que permitirá criar uma conta e buscar filmes em uma API e montar uma galeria pessoal de filmes favoritos, com poster e nota avaliativa do usuário par o filme.

## Objetivos

- Criar uma Galeria Personalizada por Usuário de Filmes Favoritos
- Conectar o APP com uma API ( base de dados ) de filmes ( TMDB )
- Permitir a criação de contas para cada usuário

## Levantamento de Requisitos do Projeto

- ### Funcionais

- ### Não Funcionais

## Recursos do Projeto

- Linguagem de Programação : Flutter / Dart
- API TMDB : Base de Dados para filmes
- Firebase : Authentication / FireStore
- Figma : Prototipagem
- VSCode
- GitHub

## Diagramas

1. Classe
   Demonstrar o funcionamento das entidades do sistema

- Usuário ( User ): Classe já modelada pelo FirebaseAuth

  - Atributos : email, senha, uid
  - Métodos : login, registrar, logout

- Filmes Favoritos ( FavoriteMovie ) : Classe Modelada pelo DEV
  - Atributos : id, título, PosterPatch, Nota
  - Métodos : adicionar, remover, listar, atualizarNota ( CRUD )

```mermaid
    classDiagram
        class User{
            +String uid
            +String email
            +String password
            +createUser()
            +login()
            +logout()
        }
        class FavoriteMovie{
            +int id
            +String title
            +String posterpatch
            +double Rating
            +addFavorite()
            +removerFavorite()
            +updateMovieRating()
            +getFavoriteMovies()
        }

        User "1" -- "1+" FavoriteMovie: "select"
```

2. ### Uso
   Ação que os Atores podem Fazer

- Usuário (User):
  - Registrar
  - Login
  - Logout
  - Procurar Filmes na APi
  - Salvar Filmes aos Favoritos
  - Dar Nota aos Filmes Favorito
  - Remover Filme dos Favoritos

```mermaid

graph TD
    subgraph "Ações"
        ac1([Registrar])
        ac2([Login])
        ac3([Logout])
        ac4([SearchMovies])
        ac5([AddFavoriteMovie])
        ac6([UpdateRatingMovie])
        ac7([RemoveFavoriteMovie])
    end

    user([Usuário])

    user --> ac1
    user --> ac2

    ac1 --> ac2
    ac2 --> ac3
    ac2 --> ac4
    ac2 --> ac5
    ac2 --> ac6
    ac2 --> ac7
```

3. ### Fluxo
   Determina o Caminho Percorrido pelo Ator para Executar uma Ação

- Fluxo da Ação de Login

```mermaid

graph TD
    A[Início] --> B{Login Usuário}
    B --> C[Inserir Email e Senha]
    C --> D{Validar as Credenciais}
    D --> E[SIM]
    D --> F[NÃO]
    E --> G[HomePage]
    F --> B
```

## Prototipagem

Link dos Protótipos

## Codificação

- Service --> Conectar com a API
- Model --> Favorite Movie
- Controller --> FireStore DataBase(Incompleto)
- View --> Registro, Login, FavoriteView, SearchView
