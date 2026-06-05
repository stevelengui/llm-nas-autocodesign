#!/bin/bash

echo "🚀 Starting LLM-NAS AutoCoDesign - PAPER-ALIGNED VERSION"
echo "========================================================"
echo ""

# Stop existing processes
pkill -f "python.*app" 2>/dev/null
pkill -f "http.server" 2>/dev/null

# Create directories
mkdir -p logs generated_projects

# Start backend
cd backend
echo "📡 Starting backend API on http://localhost:5000..."
python3 app_aligned.py > ../logs/backend.log 2>&1 &
BACKEND_PID=$!
echo "   PID: $BACKEND_PID"

sleep 3

# Start frontend
cd ../frontend
echo "🌐 Starting frontend on http://localhost:8080..."
python3 -m http.server 8080 > ../logs/frontend.log 2>&1 &
FRONTEND_PID=$!
echo "   PID: $FRONTEND_PID"

sleep 2

echo ""
echo "✅ SYSTEM READY!"
echo "================"
echo "🌐 Web Interface: http://localhost:8080"
echo "🔧 API Backend:   http://localhost:5000"
echo ""
echo "📊 Paper-Aligned Features:"
echo "   ✓ 21,600 design space exploration"
echo "   ✓ NSGA-II + MOEA/D multi-objective optimization"
echo "   ✓ QNN-SNN Hybrid (373,128 parameters)"
echo "   ✓ Sparse attention + saliency maps (0.1ms overhead)"
echo "   ✓ MAML meta-learning (5-shot, 99% retention)"
echo "   ✓ RV32X-SQ custom instructions"
echo "   ✓ 6 benchmark datasets"
echo ""
echo "📋 API Tests:"
echo "   curl http://localhost:5000/api/health"
echo "   curl -X POST http://localhost:5000/api/explore -H 'Content-Type: application/json' -d '{\"algorithm\":\"nsga2\"}'"
echo "   curl -X POST http://localhost:5000/api/generate/strict -H 'Content-Type: application/json' -d '{\"domain\":\"medical\",\"mcu\":\"riscv_rv32x\"}'"
echo ""
echo "🛑 To stop: pkill -f 'python' && pkill -f 'http.server'"
