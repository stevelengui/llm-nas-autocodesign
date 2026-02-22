#!/bin/bash

echo "🚀 Starting LLM-NAS AutoCoDesign System"
echo "======================================="

# Kill existing processes
pkill -f "python.*app.py" 2>/dev/null
pkill -f "http.server" 2>/dev/null

# Start backend
cd backend
python app.py &
BACKEND_PID=$!
cd ..

# Wait for backend
sleep 3

# Start frontend
cd frontend
python3 -m http.server 8080 &
FRONTEND_PID=$!
cd ..

echo ""
echo "✅ System Started!"
echo "=================="
echo "Frontend: http://localhost:8080"
echo "Backend:  http://localhost:5000"
echo ""
echo "Test the system:"
echo "curl -X POST http://localhost:5000/api/generate \\"
echo "  -H 'Content-Type: application/json' \\"
echo "  -d '{\"domain\":\"medical\",\"mcu\":\"riscv\",\"latency\":10,\"memory\":128,\"power\":30}'"
echo ""
echo "Press Ctrl+C to stop"
echo ""

# Keep script running
wait $BACKEND_PID $FRONTEND_PID
