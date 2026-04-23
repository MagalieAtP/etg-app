# ----------- BUILD FRONTEND -----------
FROM node:18 AS builder

WORKDIR /app

COPY frontend ./frontend

WORKDIR /app/frontend
RUN npm install
RUN npm run build


# ----------- RUN APP -----------
FROM node:18

WORKDIR /app

COPY backend ./backend
COPY --from=builder /app/frontend/dist ./frontend/dist

COPY package.json .
RUN npm install

EXPOSE 3000

CMD ["npm", "start"]
