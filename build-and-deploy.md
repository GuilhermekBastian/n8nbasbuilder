# Guia Passo a Passo - Docker Image para n8n com suporte a iframe

## Opção 1: Build Local + Docker Hub (Mais Rápido)

### 1. Instalar Docker Desktop
- Download: https://www.docker.com/products/docker-desktop/
- Instale e inicie o Docker Desktop

### 2. Criar conta no Docker Hub
- Acesse: https://hub.docker.com/signup
- Crie uma conta gratuita

### 3. Build e Push da Imagem

```bash
# Entre no diretório
cd n8n-nginx-dockerfile

# Faça login no Docker Hub
docker login

# Build da imagem (substitua 'seu-usuario' pelo seu username do Docker Hub)
docker build -t seu-usuario/n8n-iframe:latest .

# Push para o Docker Hub
docker push seu-usuario/n8n-iframe:latest
```

### 4. Atualizar no Render
1. No dashboard do Render
2. Vá em Settings do serviço n8n-bastech
3. Em "Image URL", mude de `n8nio/n8n:latest` para `seu-usuario/n8n-iframe:latest`
4. Em "Docker Command", deixe vazio
5. Save Changes

## Opção 2: GitHub + GitHub Actions (Automático)

### 1. Criar Repositório no GitHub
```bash
# Crie um novo repositório chamado 'n8n-iframe'
# No GitHub.com, clique em "New repository"

# Clone localmente
git clone https://github.com/seu-usuario/n8n-iframe.git
cd n8n-iframe

# Copie os arquivos
cp -r ../n8n-nginx-dockerfile/* .

# Commit inicial
git add .
git commit -m "Initial commit - n8n with nginx for iframe support"
git push origin main
```

### 2. Configurar GitHub Actions
Crie `.github/workflows/docker-build.yml`:

```yaml
name: Build and Push Docker Image

on:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Login to Docker Hub
      uses: docker/login-action@v2
      with:
        username: ${{ secrets.DOCKER_USERNAME }}
        password: ${{ secrets.DOCKER_PASSWORD }}
    
    - name: Build and push
      uses: docker/build-push-action@v4
      with:
        push: true
        tags: ${{ secrets.DOCKER_USERNAME }}/n8n-iframe:latest
```

### 3. Configurar Secrets no GitHub
1. No repositório, vá em Settings → Secrets → Actions
2. Adicione:
   - `DOCKER_USERNAME`: seu username do Docker Hub
   - `DOCKER_PASSWORD`: sua senha do Docker Hub

### 4. Push e Deploy
```bash
git add .github/workflows/docker-build.yml
git commit -m "Add GitHub Actions workflow"
git push origin main
```

## Verificação

Após o deploy no Render com a nova imagem:

1. Aguarde o serviço reiniciar (3-5 minutos)
2. Teste diretamente: https://n8n-bastech.onrender.com/
3. Se funcionar, o iframe em https://bastech-app-builder.vercel.app/admin/orchestration/studio também funcionará!

## Portas e Configuração

- **Porta no Render**: Mude de 5678 para 8080
- **Health Check Path**: /
- **Environment Variables**: Mantenha as mesmas

## Troubleshooting

Se não funcionar:
1. Verifique os logs no Render
2. Confirme que a porta está como 8080
3. Verifique se o Docker Command está vazio
4. Tente fazer hard refresh (Ctrl+F5) no navegador
