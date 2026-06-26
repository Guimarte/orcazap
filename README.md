# 🐋 OrcaZap — Sistema de Orçamentos Premium para Oficinas

**OrcaZap** é um aplicativo mobile moderno, de alta fidelidade e premium, desenvolvido em Flutter e integrado ao Supabase. Ele foi projetado especificamente para ajudar proprietários de oficinas mecânicas e automotivas a gerenciar, aprovar e compartilhar orçamentos de serviços e peças de forma rápida e eficiente diretamente pelo WhatsApp ou PDF.

---

## ✨ Recursos Principais

### 📊 Painel de Controle (Dashboard)
- **Métricas em Tempo Real**: Total de orçamentos criados no dia, quantidade geral de orçamentos pendentes e aprovados, total de ordens geradas na semana e faturamento acumulado semanal (apenas de orçamentos aprovados).
- **Lista de Orçamentos Recentes**: Visualização dinâmica e rápida do histórico com status colorido.

### 📝 Criação e Edição de Orçamentos
- **Dados do Cliente**: Nome, telefone para contato e identificadores (CPF/CNPJ).
- **Dados do Veículo**: Marca, modelo, ano, placa e quilometragem (KM).
- **Itens do Orçamento**: Adição de peças e serviços de forma fluida, calculando automaticamente subtotais, descontos gerais e total final.
- **Forma de Pagamento e Observações**: Configuração flexível de termos e validade do orçamento (em dias).
- **Gerenciamento de Status**: Controle visual completo do status do orçamento:
  - 🟡 **Pendente** (Aguardando resposta do cliente)
  - 🟢 **Aprovado** (Serviço pronto para execução ou em andamento)
  - 🔴 **Negado** (Orçamento recusado)

### 📲 Compartilhamento Instantâneo
- **WhatsApp**: Envio rápido do resumo formatado em texto para o número do cliente com apenas um clique.
- **Geração de PDF**: Geração automática de documento PDF contendo o logo e detalhes da oficina, dados do cliente/veículo e a listagem completa dos serviços para compartilhamento.

### 🔐 Segurança e Autenticação
- Autenticação de usuários usando **Supabase Auth**.
- Suporte a cadastro e login por e-mail e senha tradicionais.
- Suporte a login nativo e simplificado por **Google Sign-In**.

---

## 🛠️ Stack Tecnológica

- **Framework**: [Flutter](https://flutter.dev) (Dart)
- **Gerenciamento de Estado**: [flutter_bloc](https://pub.dev/packages/flutter_bloc) (Arquitetura Cubit)
- **Roteamento e Navegação**: [GoRouter](https://pub.dev/packages/go_router)
- **Banco de Dados & Autenticação**: [Supabase](https://supabase.com)
- **Geração de PDFs**: [pdf](https://pub.dev/packages/pdf)
- **Design System**: Tema escuro (Dark Theme) customizado e premium com estética moderna (Glassmorphism, bordas suaves, paleta HSL e micro-animações).

---

## 🏗️ Arquitetura do Projeto

O código-fonte segue a estrutura de **Clean Architecture** baseada em Features:

```text
lib/
├── core/                  # Utilitários compartilhados, tema e chaves do app
│   ├── theme/             # Design System (AppTheme, AppColors, AppTextStyles)
│   └── utils/             # Helpers (PdfHelper, validadores)
│
├── data/                  # Camada de Dados e Integrações
│   ├── models/            # Modelos tipados (BudgetModel, ShopModel, etc.)
│   └── repositories/      # Repositórios de acesso ao Supabase (BudgetRepository, ShopRepository)
│
├── features/              # Funcionalidades da Aplicação
│   ├── home/              # Dashboard principal e lista de orçamentos
│   ├── login/             # Login tradicional e Google Sign-In
│   ├── register/          # Cadastro de oficinas mecânicas
│   └── create_budget/     # Criação, edição e detalhamento de orçamentos
│
└── shared/                # Widgets reutilizáveis em todo o app (botões, inputs, rotas)
```

---

## 🚀 Como Iniciar o Projeto

### Pré-requisitos
- Flutter SDK na versão estável instalada.
- Um projeto configurado no [Supabase](https://supabase.com).

### Passo a Passo

1. **Clonar o Repositório**:
   ```bash
   git clone <url-do-repositorio>
   cd orcazap
   ```

2. **Instalar as Dependências**:
   ```bash
   flutter pub get
   ```

3. **Configurar as Variáveis de Ambiente**:
   Crie ou edite o arquivo de configuração correspondente com as chaves do seu Supabase (`supabaseUrl` e `supabaseAnonKey`).

4. **Executar o Aplicativo**:
   ```bash
   flutter run
   ```
