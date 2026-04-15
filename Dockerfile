FROM oven/bun:latest

# Instalar ripgrep (recomendado pelo OpenClaude) e Node.js para rodar o dist
RUN apt-get update && apt-get install -y ripgrep nodejs && rm -rf /var/lib/apt/lists/*

# Definir diretório da ferramenta
WORKDIR /app

# Copiar arquivos de dependências
COPY package.json bun.lock tsconfig.json ./

# Instalar dependências
RUN bun install

# Copiar o restante do código
COPY . .

# Compilar o OpenClaude
RUN bun run build

# O ponto de entrada padrão será o diretório onde o usuário for trabalhar
WORKDIR /workspace

# O comando para iniciar a CLI
ENTRYPOINT ["node", "/app/dist/cli.mjs"]
