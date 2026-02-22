# scripts/start.sh
#!/bin/bash

echo "🚀 Starting LLM-NAS AutoCoDesign with STRICT Compliance..."

# Stop existing processes
pkill -f "python.*backend" 2>/dev/null
pkill -f "http.server" 2>/dev/null

# Create directories
mkdir -p ~/LLMNAS_Corrected/logs
mkdir -p ~/LLMNAS_Corrected/generated_projects

# Start backend
cd ~/LLMNAS_Corrected/backend
python backend_complete.py > ../logs/backend.log 2>&1 &
BACKEND_PID=$!
echo "✅ Backend started (PID: $BACKEND_PID)"

# Wait for backend
sleep 3
if curl -s http://localhost:5000/api/health >/dev/null; then
    echo "✅ Backend API ready"
else
    echo "❌ Backend failed to start"
    exit 1
fi

# Start frontend
cd ../frontend
python3 -m http.server 8080 > ../logs/frontend.log 2>&1 &
FRONTEND_PID=$!
echo "✅ Frontend started (PID: $FRONTEND_PID)"

sleep 2

echo ""
echo "🎉 SYSTEM READY!"
echo "================"
echo "🌐 Web Interface: http://localhost:8080"
echo "🔧 API Backend:   http://localhost:5000"
echo ""
echo "📊 Features:"
echo "  • QNN-SNN Hybrid Model (373K params)"
echo "  • STRICT Compliance (3 requirements)"
echo "  • Real-time generation with progress"
echo "  • File preview and download"
echo ""
echo "🛑 To stop: ./scripts/stop.sh"
