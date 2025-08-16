# Guia Passo a Passo - GitHub Actions

## Passo 1: Criar Repositório no GitHub

1. Acesse: https://github.com/new
2. Nome do repositório: `n8n-iframe`
3. Descrição: "n8n with nginx proxy for iframe support"
4. Deixe como **Public**
5. **NÃO** inicialize com README
6. Clique em "Create repository"

## Passo 2: Preparar os Arquivos Localmente

No terminal, execute estes comandos:

```bash
# Voltar para o diretório principal
cd ~/Desktop/BASTECH\ -\ APP\ BUILDER/bastech

# Criar novo diretório para o projeto
mkdir ../n8n-iframe
cd ../n8n-iframe

# Copiar os arquivos necessários
cp -r ../bastech/n8n-nginx-dockerfile/* .
cp -r ../bastech/n8n-nginx-dockerfile/.* . 2>/dev/null || true

# Inicializar git
git init
git add .
git commit -m "Initial commit - n8n with nginx for iframe support"

# Adicionar o remote (SUBSTITUA 'seu-usuario' pelo seu username do GitHub)
git remote add origin https://github.com/seu-usuario/n8n-iframe.git

# Push inicial
git branch -M main
git push -u origin main
```

## Passo 3: Criar Conta no Docker Hub (se ainda não tiver)

1. Acesse: https://hub.docker.com/signup
2. Crie uma conta gratuita
3. Anote seu username (será usado nos secrets)

## Passo 4: Configurar Secrets no GitHub

1. No seu repositório `n8n-iframe` no GitHub
2. Vá em: **Settings** → **Secrets and variables** → **Actions**
3. Clique em **"New repository secret"**

Adicione estes 2 secrets:

**Secret 1:**
- Name: `DOCKER_USERNAME`
- Secret: (seu username do Docker Hub)

**Secret 2:**
- Name: `DOCKER_PASSWORD`
- Secret: (sua senha do Docker Hub)

## Passo 5: Verificar o Build

1. Após adicionar os secrets, vá em **Actions** no repositório
2. Você verá o workflow rodando automaticamente
3. Aguarde o build completar (cerca de 5-10 minutos)
4. Se der erro, clique para ver os detalhes

## Passo 6: Atualizar o Render

Quando o build estiver verde (sucesso):

1. No dashboard do Render
2. Vá no serviço `n8n-bastech`
3. Em **Settings**:
   - **Image URL**: `seu-username-docker/n8n-iframe:latest`
   - **Port**: `8080` (IMPORTANTE: mudar de 5678 para 8080)
   - **Docker Command**: (deixar vazio)
4. **Save Changes**

## Passo 7: Aguardar Deploy

1. O Render vai fazer pull da nova imagem
2. Aguarde 3-5 minutos
3. Quando estiver "Live" novamente, teste

## Verificação Final

1. Acesse: https://n8n-bastech.onrender.com/
2. Se funcionar, teste o iframe em: https://bastech-app-builder.vercel.app/admin/orchestration/studio
3. O iframe deve carregar sem erros!

## Troubleshooting

**Build falhou no GitHub Actions?**
- Verifique se os secrets estão corretos
- O username deve ser exatamente igual ao Docker Hub

**Render não está funcionando?**
- Confirme que mudou a porta para 8080
- Verifique os logs no Render
- Certifique-se que o Docker Command está vazio

**Ainda com erro de iframe?**
- Faça hard refresh (Ctrl+F5)
- Limpe o cache do navegador
- Verifique o console (F12) para erros
