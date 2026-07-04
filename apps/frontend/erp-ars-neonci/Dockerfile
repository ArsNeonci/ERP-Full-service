# Stage 1: Install Dependencies
FROM node:26.4.0-alpine3.24 AS deps
WORKDIR /app
COPY package*.json ./
RUN npm ci

# Stage 2: Build
FROM node:26.4.0-alpine3.24 AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
# FIX: Sử dụng dấu "=" cho chuẩn cú pháp ENV mới
ENV NEXT_TELEMETRY_DISABLED=1
RUN npm run build 

# Stage 3: Production Runner (Chế độ Standalone siêu nhẹ)
FROM node:26.4.0-alpine3.24 AS runner
WORKDIR /app
# FIX: Sử dụng dấu "=" 
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

RUN addgroup --system --gid 1001 nodejs && adduser --system --uid 1001 nextjs

COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next/standalone ./
COPY --from=builder --chown=nextjs:nodejs /app/.next/static ./.next/static

USER nextjs
EXPOSE 3000
CMD ["node", "server.js"]