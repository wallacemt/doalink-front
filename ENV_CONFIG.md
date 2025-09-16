# DoaLink - Configuração de Ambiente

## 🔐 Configuração de Variáveis de Ambiente

Este projeto usa variáveis de ambiente para manter informações sensíveis seguras e fora do controle de versão.

### 📋 Passo a Passo

1. **Copie o arquivo de exemplo:**

   ```bash
   cp .env.example .env
   ```

2. **Obtenha sua chave da API do Google Maps:**

   - Acesse o [Google Cloud Console](https://console.cloud.google.com/)
   - Crie ou selecione um projeto
   - Ative a API do Google Maps (Maps SDK for Android/iOS)
   - Vá em "Credenciais" e crie uma chave de API
   - Configure as restrições da API conforme necessário

3. **Edite o arquivo `.env`:**
   ```env
   GOOGLE_MAPS_API_KEY=sua_chave_aqui
   ```

### 🔧 Como Funciona

- **Flutter (Dart):** Usa `flutter_dotenv` para carregar variáveis no runtime
- **Android:** Usa Gradle para injetar a chave no AndroidManifest.xml durante o build
- **Segurança:** O arquivo `.env` está no `.gitignore` e nunca será commitado

### 📁 Estrutura de Arquivos

```
├── .env                 # Suas variáveis (não versionado)
├── .env.example         # Template das variáveis (versionado)
├── lib/config/          # Configurações da aplicação
│   └── app_config.dart  # Helper para acessar variáveis
└── android/app/
    ├── build.gradle.kts # Injeta variáveis no build
    └── src/main/
        └── AndroidManifest.xml # Usa placeholders
```

### 🚀 Executando o Projeto

```bash
# Instalar dependências
flutter pub get

# Executar em debug
flutter run

# Build para release
flutter build apk --release
```

### ⚠️ Importante

- Nunca commite o arquivo `.env`
- Use `.env.example` como template para outros desenvolvedores
- Mantenha suas chaves de API seguras
- Configure restrições apropriadas no Google Cloud Console

### 🔍 Validação

O app verifica automaticamente se as configurações estão corretas:

- No `MapScreen`, uma notificação aparece se a chave não estiver configurada
- Use `AppConfig.getConfigStatus()` para debug das configurações

### 📱 Permissões Android

O projeto já está configurado com as permissões necessárias:

- `INTERNET`
- `ACCESS_FINE_LOCATION`
- `ACCESS_COARSE_LOCATION`
- `ACCESS_NETWORK_STATE`
