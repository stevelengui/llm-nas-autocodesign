#!/bin/bash

echo "🚀 Starting LLM-NAS Backend (Simple)"

# Kill existing
pkill -f "python.*app" 2>/dev/null
sleep 1

# Clean port 5000
fuser -k 5000/tcp 2>/dev/null

# Create directories
mkdir -p generated_projects logs

# Start backend
cd backend
python app_real.py &
BACKEND_PID=$!
echo $BACKEND_PID > ../backend.pid

# Wait
echo "⏳ Waiting for backend..."
sleep 3

# Test
if curl -s http://localhost:5000/api/health > /dev/null; then
    echo "✅ Backend started!"
    echo "🌐 URL: http://localhost:5000"
    echo "📊 Model: $(curl -s http://localhost:5000/api/health | python3 -c "import json,sys; d=json.load(sys.stdin); print(f\"{d.get('parameters'):,} parameters, {d.get('memory_kb'):.2f} KB\")")"
else
    echo "❌ Backend failed to start"
    echo "Check logs: tail -f logs/backend.log"
fi
