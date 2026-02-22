#!/bin/bash
echo "🛑 Stopping LLM-NAS System..."
pkill -f "python" 2>/dev/null
pkill -f "http.server" 2>/dev/null
echo "✅ System stopped"
