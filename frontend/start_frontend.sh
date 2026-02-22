#!/bin/bash

echo "🌐 Starting LLM-NAS Frontend..."
cd ~/LLMNAS_Corrected/frontend

# Arrêter l'ancien serveur
pkill -f "http.server" 2>/dev/null

# Démarrer le serveur
python3 -m http.server 8080 &
FRONTEND_PID=$!

echo "✅ Frontend started with PID: $FRONTEND_PID"
echo "🌐 URL: http://localhost:8080"
echo ""
echo "Backend API: http://localhost:5000"
echo ""
echo "To stop: pkill -f 'http.server'"
