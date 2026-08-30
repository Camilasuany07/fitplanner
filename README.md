# FitPlanner

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white" alt="Android" />
</p>

Aplicativo mobile para organização e acompanhamento de treinos pessoais, desenvolvido em Flutter com foco em produtividade, rotina fitness e visualização de progresso.

## 🚀 Sobre o projeto

O FitPlanner é um app de treino pensado para ajudar o usuário a:

- cadastrar treinos personalizados;
- adicionar exercícios por sessão;
- acompanhar treinos do dia;
- visualizar progresso semanal;
- iniciar um treino com cronômetro;
- manter o histórico salvo localmente no celular.

## ✨ Funcionalidades implementadas

- Tela inicial com resumo diário
- Dashboard de meta semanal
- Cadastro de treinos
- Edição de treinos existentes
- Exibição de exercícios por treino
- Temporizador de treino
- Persistência local com SharedPreferences
- Interface dark mode
- Cards e gráficos de progresso

## 🧩 Stack utilizada

- Flutter
- Dart
- Material Design 3
- SharedPreferences
- fl_chart

## 📁 Estrutura do projeto

```text
fitplanner/
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
├── android/
├── ios/
├── test/
├── pubspec.yaml
├── README.md
├── DOCUMENTACAO_PROJETO.md
└── analysis_options.yaml
```

## 🏃 Como executar

1. Clone o projeto:

```bash
git clone <url-do-repositorio>
```

2. Entre na pasta:

```bash
cd fitplanner
```

3. Instale as dependências:

```bash
flutter pub get
```

4. Execute o app:

```bash
flutter run
```

## 📱 Build para Android

### APK de release

```bash
flutter build apk --release
```

Arquivo gerado em:

```bash
build/app/outputs/flutter-apk/app-release.apk
```

### Instalação direta no dispositivo

```bash
flutter install --release
```

## 📌 Status

- Projeto funcional: sim
- Persistência implementada: sim
- Fluxo principal concluído: sim
- Pronto para testes locais: sim

## 🔮 Próximos passos

- histórico por semana/mês
- filtros de treino
- perfil do usuário
- notificações e lembretes
- visualizações mais detalhadas de desempenho
- melhorias de UX e refinamento visual

## 🧠 Conclusão

O FitPlanner já entrega uma base sólida de aplicativo fitness, com foco em simplicidade, organização e acompanhamento diário. O projeto está bem posicionado para evoluir com novas funcionalidades e melhorias de experiência.
