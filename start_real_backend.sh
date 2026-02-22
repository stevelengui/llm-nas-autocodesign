#!/bin/bash

echo "🚀 STARTING LLM-NAS BACKEND WITH REAL DATA"
echo "=========================================="

# Arrêter les processus existants
pkill -f "python.*app" 2>/dev/null
sleep 2

# Vérifier le port
if lsof -Pi :5000 -sTCP:LISTEN -t >/dev/null ; then
    echo "⚠️ Port 5000 in use. Killing..."
    lsof -ti:5000 | xargs kill -9
    sleep 2
fi

# Créer les dossiers nécessaires
mkdir -p generated_projects logs

# Vérifier les dépendances
echo "🔍 Checking dependencies..."
python3 -c "import numpy, flask" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "📦 Installing dependencies..."
    pip install numpy flask flask-cors waitress
fi

# Démarrer le backend
echo "⚙️ Starting backend with REAL QSNN data..."
cd backend
python app_real.py > ../logs/backend_real.log 2>&1 &
BACKEND_PID=$!
echo $BACKEND_PID > ../backend_real.pid

# Attendre le démarrage
echo "⏳ Waiting for backend to start..."
for i in {1..15}; do
    if curl -s http://localhost:5000/api/health > /dev/null; then
        echo "✅ Backend started successfully!"
        echo "📊 Model stats:"
        curl -s http://localhost:5000/api/model/stats | python3 -c "
import json, sys
data = json.load(sys.stdin)
if data.get('status') == 'success':
    model = data['model']
    print(f'  Name: {model[\"name\"]}')
    print(f'  Parameters: {model[\"total_parameters\"]:,}')
    print(f'  Memory: {model[\"total_bytes\"]} bytes ({model[\"total_bytes\"]/1024:.3f} KB)')
    print(f'  Layers: {len(model[\"layers\"])}')
"
        break
    fi
    echo "  Attempt $i/15..."
    sleep 1
done

echo ""
echo "🌐 API Endpoints:"
echo "  Main:          http://localhost:5000"
echo "  Health:        http://localhost:5000/api/health"
echo "  Model Stats:   http://localhost:5000/api/model/stats"
echo "  Generate:      POST http://localhost:5000/api/generate"
echo ""
echo "📁 Project directory: ./generated_projects/"
echo "📋 Logs: ./logs/backend_real.log"
echo ""
echo "🧪 Test generation:"
echo 'curl -X POST http://localhost:5000/api/generate \'
echo '  -H "Content-Type: application/json" \'
echo '  -d '\''{
    "domain": "medical",
    "mcu": "riscv",
    "latency": 20,
    "memory": 64,
    "power": 50
  }'\'
echo ""
echo "🛑 To stop: kill $BACKEND_PID"
