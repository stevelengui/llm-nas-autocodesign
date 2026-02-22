#!/bin/bash

echo "🚀 Starting LLM-NAS AutoCoDesign System"
echo "======================================="

# Kill existing processes
pkill -f "python.*app.py" 2>/dev/null
pkill -f "http.server" 2>/dev/null

# Add current directory to Python path
export PYTHONPATH=$PYTHONPATH:$(pwd)

# Start backend
echo "Starting backend..."
cd backend
python app.py &
BACKEND_PID=$!
cd ..

sleep 3

# Check if backend is running
if curl -s http://localhost:5000/api/health > /dev/null; then
    echo "✅ Backend started successfully"
else
    echo "❌ Backend failed to start"
    exit 1
fi

# Start frontend
echo "Starting frontend..."
cd frontend
python3 -m http.server 8080 &
FRONTEND_PID=$!
cd ..

sleep 2

echo ""
echo "✅ System Started Successfully!"
echo "================================"
echo "Frontend: http://localhost:8080"
echo "Backend:  http://localhost:5000"
echo ""
echo "📊 System Status:"
curl -s http://localhost:5000/api/health | python3 -m json.tool
echo ""
echo "🧠 Model Info:"
curl -s http://localhost:5000/api/model/info | python3 -m json.tool
echo ""
echo "🎯 Test Examples:"
echo "1. Medical domain:"
echo "curl -X POST http://localhost:5000/api/generate \\"
echo "  -H 'Content-Type: application/json' \\"
echo "  -d '{\"domain\":\"medical\",\"mcu\":\"riscv\",\"latency\":10,\"memory\":128,\"power\":30}'"
echo ""
echo "2. IoT domain:"
echo "curl -X POST http://localhost:5000/api/generate \\"
echo "  -H 'Content-Type: application/json' \\"
echo "  -d '{\"domain\":\"iot\",\"mcu\":\"esp32\",\"latency\":50,\"memory\":32,\"power\":20}'"
echo ""
echo "Press Ctrl+C to stop"
echo ""

# Keep script running
wait $BACKEND_PID $FRONTEND_PID
