"""
Backend permanent LLM-NAS - Toujours sur port 5200
"""
from flask import Flask, jsonify, request
from flask_cors import CORS
import json
import os
from datetime import datetime

app = Flask(__name__)
CORS(app, origins=["http://localhost:8100", "http://127.0.0.1:8100"])

@app.route('/api/health')
def health():
    return jsonify({
        "status": "healthy",
        "port": 5200,
        "service": "LLM-NAS Permanent",
        "timestamp": datetime.now().isoformat()
    })

@app.route('/api/generate', methods=['POST'])
def generate():
    try:
        data = request.json or {}
        project_id = f"proj_{datetime.now().strftime('%Y%m%d_%H%M%S')}"
        
        return jsonify({
            "status": "success",
            "project_id": project_id,
            "backend_port": 5200,
            "message": "Project generated successfully",
            "files": ["main.c", "config.h", "README.md"]
        })
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/')
def index():
    return jsonify({
        "service": "LLM-NAS AutoCoDesign",
        "version": "2.0.0",
        "backend_port": 5200,
        "permanent": True
    })

if __name__ == '__main__':
    print("="*50)
    print("🚀 LLM-NAS PERMANENT BACKEND")
    print("📡 PORT: 5200 (FIXE)")
    print("🌐 CORS: http://localhost:8100")
    print("="*50)
    app.run(host='0.0.0.0', port=5200, debug=True)
