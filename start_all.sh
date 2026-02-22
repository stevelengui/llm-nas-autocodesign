#!/bin/bash

echo "🚀 STARTING LLM-NAS AutoCoDesign COMPLETE SYSTEM"
echo "================================================"

# 1. Arrêter tout processus existant
echo "🛑 Stopping existing processes..."
sudo lsof -ti:5000 | xargs kill -9 2>/dev/null
pkill -f "python.*app.py" 2>/dev/null
pkill -f "http.server" 2>/dev/null
sleep 2

# 2. Vérifier les ports
echo "🔍 Checking ports..."
if netstat -tuln | grep -q ":5000 "; then
    echo "❌ Port 5000 still in use. Force stopping..."
    sudo fuser -k 5000/tcp
    sleep 2
fi

# 3. Démarrer le backend
echo "⚙️ Starting backend API..."
cd backend
python app.py > ../logs/backend.log 2>&1 &
BACKEND_PID=$!
echo $BACKEND_PID > ../backend.pid
echo "  Backend PID: $BACKEND_PID"

# Attendre que le backend démarre
echo "⏳ Waiting for backend..."
for i in {1..10}; do
    if curl -s http://localhost:5000/api/health > /dev/null; then
        echo "✅ Backend is responding!"
        break
    fi
    echo "  Attempt $i/10..."
    sleep 1
done

# 4. Démarrer le frontend
echo "🌐 Starting frontend..."
cd ../frontend
python3 -m http.server 8080 > ../logs/frontend.log 2>&1 &
FRONTEND_PID=$!
echo $FRONTEND_PID > ../frontend.pid
echo "  Frontend PID: $FRONTEND_PID"

# Attendre
sleep 2

# 5. Afficher les informations
echo ""
echo "🎉 SYSTEM STARTED SUCCESSFULLY!"
echo "================================"
echo ""
echo "🌐 ACCESS LINKS:"
echo "  Frontend Interface:  http://localhost:8080"
echo "  Backend API:         http://localhost:5000"
echo "  API Health Check:    http://localhost:5000/api/health"
echo ""
echo "📊 COMMANDS:"
echo "  Generate project:    curl -X POST http://localhost:5000/api/generate \\"
echo "                       -H \"Content-Type: application/json\" \\"
echo "                       -d '{\"domain\":\"industrial\",\"mcu\":\"riscv\",\"latency\":20}'"
echo ""
echo "  List projects:       curl http://localhost:5000/api/projects"
echo ""
echo "🛑 STOP:"
echo "  ./stop_all.sh"
echo ""
echo "📋 LOGS:"
echo "  Backend logs:  tail -f logs/backend.log"
echo "  Frontend logs: tail -f logs/frontend.log"
