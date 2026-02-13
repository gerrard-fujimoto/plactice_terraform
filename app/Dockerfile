# 1. ベースイメージをBunの公式イメージに設定
FROM oven/bun:1

# 2. 作業ディレクトリ
WORKDIR /app

# 3. 依存関係ファイルのコピー
# bun.lockb がある場合はそれもコピーします
COPY package.json bun.lockb* ./

# 4. 依存関係のインストール (bun install)
# --frozen-lockfile は npm ci に相当する、厳密なインストールコマンドです
RUN bun install --frozen-lockfile

# 5. ソースコードのコピー
COPY . .

# 6. ビルド (Next.js のビルド)
RUN bun run build

# 7. ポート開放
EXPOSE 3000

# 8. 起動コマンド
CMD ["bun", "start"]
