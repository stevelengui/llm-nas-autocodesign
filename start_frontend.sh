#!/bin/bash

echo "🌐 Starting LLM-NAS Frontend"

# Kill existing
pkill -f "http.server" 2>/dev/null
sleep 1

# Vérifier le port
if lsof -Pi :8080 -sTCP:LISTEN -t >/dev/null ; then
    echo "⚠️ Port 8080 in use, killing..."
    fuser -k 8080/tcp 2>/dev/null
    sleep 2
fi

# Démarrer
cd frontend
python3 -m http.server 8080 > ../logs/frontend.log 2>&1 &
FRONTEND_PID=$!
echo $FRONTEND_PID > ../frontend.pid

sleep 2
echo -n "Frontend status: "
if curl -s http://localhost:8080 > /dev/null; then
    echo "✅ RUNNING"
    echo "🌐 URL: http://localhost:8080"
else
    echo "❌ FAILED"
    echo "Check logs: tail -f logs/frontend.log"
fi
