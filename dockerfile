# Utilise Node.js comme base
FROM node

# Dossier de travail dans le conteneur
WORKDIR /app

# Copie les fichiers de dépendances
COPY package*.json ./
RUN npm install

# Copie tout ton code
COPY . .

# Ton app utilise le port 3700
EXPOSE 3700

# Commande pour démarrer
CMD ["node", "app.js"]
