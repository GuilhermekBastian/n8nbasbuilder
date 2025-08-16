# n8n com Nginx para permitir iframe

Este Dockerfile cria uma imagem do n8n com nginx configurado para remover headers de segurança que bloqueiam iframes.

## Como usar:

### Opção 1: Build local e push para Docker Hub

```bash
# Build da imagem
docker build -t seu-usuario/n8n-iframe:latest .

# Push para Docker Hub (precisa fazer login primeiro)
docker login
docker push seu-usuario/n8n-iframe:latest

# No Render, use: seu-usuario/n8n-iframe:latest
```

### Opção 2: GitHub Actions (automático)

1. Crie um repositório no GitHub
2. Faça push deste código
3. Configure GitHub Actions para build automático
4. Use a imagem no Render

## Portas:

- nginx: 8080 (exposta)
- n8n: 5678 (interna)

## Funcionamento:

1. Supervisor inicia nginx e n8n
2. Nginx faz proxy removendo X-Frame-Options
3. n8n fica acessível sem restrições de iframe
