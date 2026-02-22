#!/bin/bash

cd ~/LLMNAS_Corrected

case "$1" in
    start)
        echo "🚀 Starting LLM-NAS System..."
        
        # Kill existing processes
        pkill -f "python.*app" 2>/dev/null
        pkill -f "http.server" 2>/dev/null
        
        # Start backend
        cd backend
        python app_improved.py > ../logs/backend_5001.log 2>&1 &
        echo $! > ../backend.pid
        cd ..
        
        sleep 3
        
        # Start frontend services
        cd frontend
        
        # Generator (port 8080)
        python3 -m http.server 8080 --bind 127.0.0.1 > ../logs/generator_8080.log 2>&1 &
        echo $! > ../generator.pid
        
        # Dashboard (port 8081)
        python3 -m http.server 8081 --bind 127.0.0.1 > ../logs/dashboard_8081.log 2>&1 &
        echo $! > ../dashboard.pid
        
        # Home (port 8082)
        cd ..
        python3 -m http.server 8082 --bind 127.0.0.1 --directory frontend/home > logs/home_8082.log 2>&1 &
        echo $! > ../home.pid
        
        sleep 2
        
        echo ""
        echo "✅ LLM-NAS System Started Successfully!"
        echo "========================================"
        echo "🏠 Home Page:      http://localhost:8082"
        echo "🎮 Generator:      http://localhost:8080"
        echo "📊 Dashboard:      http://localhost:8081/dashboard.html"
        echo "⚙️  Backend API:   http://localhost:5001"
        echo ""
        echo "📋 Quick Test:"
        echo "curl -X POST http://localhost:5001/api/generate \\"
        echo "  -H 'Content-Type: application/json' \\"
        echo "  -d '{\"domain\":\"medical\",\"mcu\":\"riscv\",\"latency\":10,\"memory\":128,\"power\":30}'"
        echo ""
        ;;
    
    stop)
        echo "🛑 Stopping LLM-NAS System..."
        pkill -f "python.*app" 2>/dev/null
        pkill -f "http.server" 2>/dev/null
        rm -f *.pid 2>/dev/null
        echo "✅ System stopped"
        ;;
    
    status)
        echo "📊 LLM-NAS System Status:"
        echo ""
        echo "Backend (5001):"
        if curl -s http://localhost:5001/api/health > /dev/null; then
            echo "  ✅ Running - http://localhost:5001"
            curl -s http://localhost:5001/api/health | python3 -m json.tool 2>/dev/null || echo "  Can't parse response"
        else
            echo "  ❌ Not running"
        fi
        
        echo ""
        echo "Services:"
        echo "  Generator (8080):   $(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080 2>/dev/null || echo "Offline")"
        echo "  Dashboard (8081):   $(curl -s -o /dev/null -w "%{http_code}" http://localhost:8081 2>/dev/null || echo "Offline")"
        echo "  Home (8082):        $(curl -s -o /dev/null -w "%{http_code}" http://localhost:8082 2>/dev/null || echo "Offline")"
        echo ""
        echo "Processes:"
        ps aux | grep -E "(python.*app|http.server)" | grep -v grep || echo "  No processes found"
        ;;
    
    logs)
        echo "📄 Showing logs..."
        tail -f logs/*.log
        ;;
    
    test)
        echo "🧪 Running tests..."
        
        # Test backend
        echo "1. Testing backend..."
        curl -s http://localhost:5001/api/health | python3 -m json.tool
        
        echo ""
        echo "2. Generating test project..."
        curl -X POST http://localhost:5001/api/generate \
          -H 'Content-Type: application/json' \
          -d '{"domain":"medical","mcu":"riscv","latency":10,"memory":128,"power":30}' | python3 -m json.tool
        
        echo ""
        echo "3. Listing projects..."
        curl -s http://localhost:5001/api/projects | python3 -m json.tool
        ;;
    
    *)
        echo "Usage: $0 {start|stop|status|logs|test}"
        echo ""
        echo "Commands:"
        echo "  start   - Start all services"
        echo "  stop    - Stop all services"
        echo "  status  - Check system status"
        echo "  logs    - View logs"
        echo "  test    - Run tests"
        exit 1
        ;;
esac
