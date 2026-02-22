"""
LLM-NAS Backend corrigé avec chemin absolu
"""
import os
import sys

# AJOUTER CE CHEMIN ABSOLU
sys.path.insert(0, os.path.join(os.path.dirname(__file__), '..'))

from flask import Flask, jsonify, request
from flask_cors import CORS
import json
from datetime import datetime

app = Flask(__name__)
CORS(app)

# Maintenant llm_nas devrait être trouvable
try:
    from llm_nas.real_weights import REAL_WEIGHTS
    REAL_DATA_LOADED = True
    print("✅ Vrais poids chargés !")
except ImportError as e:
    REAL_DATA_LOADED = False
    print(f"❌ Erreur import: {e}")

# API simple
@app.route('/api/health')
def health():
    return jsonify({
        "status": "healthy",
        "llm_nas_loaded": REAL_DATA_LOADED,
        "port": 5001
    })

@app.route('/')
def index():
    return jsonify({"service": "LLM-NAS", "version": "2.0"})

if __name__ == '__main__':
    print("🚀 LLM-NAS Backend sur port 5001")
    app.run(host='0.0.0.0', port=5001, debug=True)
