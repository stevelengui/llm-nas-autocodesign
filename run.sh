#!/bin/bash

echo "🚀 Starting LLM-NAS System"
echo "=========================="

# Kill old processes
pkill -f "python.*app.py" 2>/dev/null
pkill -f "http.server" 2>/dev/null

# Start backend
echo "Starting backend..."
cd backend
python app.py &
cd ..

sleep 2

# Start frontend
echo "Starting frontend..."
cd frontend
python3 -m http.server 8080 &
cd ..

sleep 1

echo ""
echo "✅ System Ready!"
echo "================"
echo "Frontend: http://localhost:8080"
echo "Backend:  http://localhost:5000"
echo ""
echo "Test with curl:"
echo "curl -X POST http://localhost:5000/api/generate \\"
echo "  -H 'Content-Type: application/json' \\"
echo "  -d '{\"domain\":\"medical\",\"mcu\":\"riscv\",\"latency\":10,\"memory\":128,\"power\":30}'"
echo ""
echo "Press Ctrl+C to stop"

# Keep running
wait
