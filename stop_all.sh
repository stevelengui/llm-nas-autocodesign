#!/bin/bash
echo "🛑 Stopping LLM-NAS AutoCoDesign System..."
pkill -f "python.*app.py" 2>/dev/null
pkill -f "http.server" 2>/dev/null
rm -f backend.pid frontend.pid 2>/dev/null
echo "✅ System stopped"
