# 📱 Fast Location

Aplicativo Flutter para consulta de endereços por CEP, com histórico local e visualização no Google Maps.

---

## ✅ Funcionalidades

- 🔎 Consultar endereços por CEP.
- 🗺️ Exibir logradouro, bairro, cidade e estado.
- 💾 Armazenar as consultas localmente (Histórico).
- 📍 Visualizar os endereços diretamente no Google Maps.
- 🤖 Suporte para Android (emulador ou dispositivo físico).

---

## 🖥️ Pré-requisitos

Antes de executar o projeto em outro computador, é necessário:

1. Ter o Flutter instalado. Siga o guia oficial:  
   👉 [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)

2. Configurar um editor como:
   - Android Studio (recomendado)
   - VS Code com as extensões de Flutter e Dart

3. Ter um dispositivo físico ou emulador Android configurado.

4. Ter o Git instalado (para clonar o projeto, opcional).

---

## 🚀 Como rodar o projeto

### 1. Clone o repositório (ou copie os arquivos do projeto)

```bash
git clone https://github.com/seu-usuario/fast_location.git
cd fast_location
```

### 2. Instale as dependências do projeto:

```bash
flutter pub get
```

### 3. Compile os arquivos do Hive:

```bash
flutter packages pub run build_runner build
```

### 4. Conecte um dispositivo ao seu computador ou conecte a um emulador:

```bash
flutter devices
```

Esse comando lista os dispositivos ou emuladores disponíveis para rodar o projeto.
Caso esteja utilizando Visual Studio Code, selecione o dispositivo na parte inferior do programa ou crie um emulador.

### 5. Rode o projeto:

```bash
flutter run
```

---

# Como usar:

### 1. Página home:

  - Digite o CEP desejado no campo de busca.
  - O endereço será exibido e armazenado no histórico.

### 2. Página de histórico:

  - Acesse pelo ícone no canto superior direito.
  - Veja todos os CEPs buscados anteriormente.
  - Use o botão de mapa ao lado de cada item para visualizar no Google Maps.

