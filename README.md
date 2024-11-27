# 🛍️ **Virtual Store App** 🎯

> Um aplicativo de e-commerce desenvolvido em **Flutter**, com funcionalidades robustas como controle de estoque, painel administrativo, integração com pagamentos via cartão de crédito e muito mais!

---

## 🚀 **Funcionalidades**

### 🌟 **Para Clientes**
- **Catálogo de Produtos:** Visualização intuitiva e organizada de produtos com filtros por categorias.
- **Carrinho de Compras:** Gerenciamento de itens com cálculo automático do valor total.
- **Pagamentos Seguros:** Integração com gateways de pagamento para transações com cartão de crédito.
- **Histórico de Pedidos:** Acompanhe compras realizadas com status atualizado.

### 🔑 **Para Administradores**
- **Controle de Estoque:** Atualize quantidade, preço e detalhes dos produtos diretamente no app.
- **Painel de Gerenciamento:** Ferramentas para adicionar, editar e remover produtos.
- **Relatórios de Vendas:** Dados sobre desempenho, produtos mais vendidos e estoque crítico.
- **Gerenciamento de Usuários:** Controle permissões e visualize informações de clientes.

---

## 🛠️ **Tecnologias Utilizadas**

- **Frontend:**
  - **Flutter:** Framework principal para o desenvolvimento do aplicativo.
  - **Provider:** Gerenciamento de estado para atualização dinâmica de telas e funcionalidades.

- **Backend:**
  - **Firebase Firestore:** Banco de dados em tempo real para armazenamento de produtos, pedidos e usuários.
  - **Firebase Authentication:** Sistema de autenticação seguro para clientes e administradores.
  - **Firebase Cloud Functions:** Processamento de lógica de negócios, como cálculo de estoques e notificações.
  - **Firebase Storage:** Armazenamento de imagens dos produtos.

- **Pagamentos:**
  - Integração com APIs de pagamento (como Stripe, PayPal ou outras opções).

---

## 📦 **Pré-requisitos**

Certifique-se de atender aos requisitos abaixo antes de executar o aplicativo:

- **Flutter SDK 3.0+**
- **Firebase CLI Configurado**
- **Chaves de API de Pagamento:** Obtenha suas credenciais nos serviços de pagamento desejados.

Instale as dependências necessárias:
```bash
flutter pub get
