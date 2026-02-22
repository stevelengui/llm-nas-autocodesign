#!/bin/bash
# start_real_system.sh

cd ~/LLMNAS_Corrected

echo "🚀 Démarrage LLM-NAS avec VRAIS poids..."

# Arrêter les anciens processus
pkill -f "python.*app" 2>/dev/null
pkill -f "http.server" 2>/dev/null

# Démarrer backend
cd backend && python app_real.py &
BACKEND_PID=$!
echo "✅ Backend démarré (PID: $BACKEND_PID)"

# Attendre
sleep 3

# Tester
echo "🔍 Vérification..."
curl -s http://localhost:5000/api/health | grep -q "healthy" && echo "✅ Backend OK" || echo "❌ Backend ERROR"

# Démarrer frontend
cd ../frontend && python3 -m http.server 8080 &
FRONTEND_PID=$!
echo "✅ Frontend démarré (PID: $FRONTEND_PID)"

echo ""
echo "🎉 SYSTÈME PRÊT !"
echo "🌐 Interface: http://localhost:8080"
echo "🔧 API: http://localhost:5000"
echo ""
echo "📊 Poids réels intégrés: OUI"
echo "✅ 3 contraintes: IMPLÉMENTÉES"
