#!/bin/bash

ENV_FILE="${SRCROOT}/../../.env"

if [ ! -f "$ENV_FILE" ]; then
    echo "Arquivo .env não encontrado em: $ENV_FILE"
    
    
    cat > "$ENV_FILE" << EOF
    GOOGLE_MAPS_API_KEY=your_google_maps_api_key_here
EOF
    
    echo "✅ Arquivo .env criado. Edite-o com suas chaves de API."
    exit 1
fi

while IFS='=' read -r key value; do
    
    if [[ $key =~ ^[[:space:]]*# ]] || [[ -z $key ]]; then
        continue
    fi
    
    key=$(echo $key | xargs)
    value=$(echo $value | xargs)
    
    value=${value//\"/}
    value=${value//\'/}
    
    export $key="$value"
    
    echo "📝 Carregando: $key"
done < "$ENV_FILE"

if [ -z "$GOOGLE_MAPS_API_KEY" ] || [ "$GOOGLE_MAPS_API_KEY" = "your_google_maps_api_key_here" ]; then
    echo "Edite o arquivo .env e adicione sua chave da API do Google Maps"
    exit 1
fi

TEMP_CONFIG="${SRCROOT}/flutter_env_config.xcconfig"

cat > "$TEMP_CONFIG" << EOF
// Arquivo gerado automaticamente - NÃO EDITAR
// Variáveis de ambiente carregadas do arquivo .env

GOOGLE_MAPS_API_KEY = $GOOGLE_MAPS_API_KEY
EOF
