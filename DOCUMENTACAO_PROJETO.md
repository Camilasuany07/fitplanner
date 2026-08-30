# FitPlanner

Aplicativo mobile para organização e acompanhamento de treinos pessoais, desenvolvido em Flutter.

## Visão geral

O FitPlanner foi criado para ajudar pessoas a gerenciar sua rotina de treino de forma prática e visual. A aplicação permite registrar treinos, acompanhar a evolução semanal e manter uma rotina organizada diretamente no celular.

## Objetivo

O objetivo principal do projeto é oferecer uma solução simples, leve e funcional para:

- criar treinos personalizados;
- acompanhar exercícios por treino;
- visualizar progresso e metas semanais;
- iniciar sessões com temporizador;
- manter os dados salvos localmente no dispositivo.

## Funcionalidades

### Tela inicial
- saudação dinâmica conforme o horário do dia;
- resumo dos treinos do dia;
- total de calorias estimadas;
- progresso semanal;
- botão para iniciar treino;
- lista de treinos recentes.

### Cadastro de treino
- nome do treino;
- duração estimada;
- quantidade de calorias;
- lista de exercícios;
- armazenamento local.

### Edição de treino
- alteração do nome, duração e calorias;
- atualização dos exercícios;
- persistência das mudanças.

### Execução do treino
- timer de duração;
- status em andamento / concluído;
- listagem dos exercícios do treino;
- mensagem de confirmação ao finalizar.

### Persistência
- uso de SharedPreferences para salvar os dados locais;
- os treinos continuam disponíveis após fechar o app.

## Tecnologias utilizadas

- Flutter
- Dart
- Material Design 3
- SharedPreferences
- fl_chart

## Estrutura do projeto

```text
fitplanner/
├── android/
├── ios/
├── lib/
│   ├── main.dart
│   ├── features/
│   │   ├── home/
│   │   │   └── pages/
│   │   └── workout/
│   │       ├── data/
│   │       ├── models/
│   │       ├── pages/
│   │       ├── services/
│   │       └── widgets/
├── test/
├── pubspec.yaml
├── README.md
└── analysis_options.yaml
```

## Arquitetura e fluxo principal

O app foi organizado em módulos por funcionalidade:

- Home: tela principal da aplicação
- Workout: fluxo completo de cadastro, edição, execução e armazenamento
- Services: camada responsável pela persistência
- Models: estrutura dos dados do treino
- Widgets: componentes visuais reutilizáveis

## Dados do app

O modelo principal de treino é representado por:

- nome
- duração
- calorias
- lista de exercícios
- data

Esses dados são convertidos para JSON e armazenados no dispositivo.

## Como executar

1. Certifique-se de ter o Flutter instalado.
2. Acesse a pasta do projeto:

```bash
cd fitplanner
```

3. Instale as dependências:

```bash
flutter pub get
```

4. Execute o projeto:

```bash
flutter run
```

## Build para Android

### Gerar APK de release

```bash
flutter build apk --release
```

Arquivo gerado:

```bash
build/app/outputs/flutter-apk/app-release.apk
```

### Instalar diretamente no dispositivo

```bash
flutter install --release
```

## Melhorias futuras

- histórico por semana e mês;
- filtros por categoria de treino;
- perfil do usuário;
- notificações de lembrete;
- mais gráficos e métricas de desempenho;
- integração com banco de dados remota;
- sincronização em nuvem.

## Conclusão

O FitPlanner já entrega uma base funcional de aplicativo de treino com foco em organização pessoal, rotina e acompanhamento diário. O projeto está em evolução e tem potencial para crescer em complexidade e usabilidade.

## Status

- Projeto funcional: sim
- Persistência implementada: sim
- Fluxo principal concluído: sim
- Versão inicial pronta para testes: sim
