from flask import Flask, jsonify, request
from flask_cors import CORS
import sys

# Ajouter llm_nas au path
sys.path.append('..')

app = Flask(__name__)

# Configuration CORS COMPLÈTE
CORS(app, resources={
    r"/*": {
        "origins": ["http://localhost:8100", "http://127.0.0.1:8100"],
        "methods": ["GET", "POST", "OPTIONS", "PUT", "DELETE"],
        "allow_headers": ["Content-Type", "Authorization", "Accept"],
        "supports_credentials": True
    }
})

# Gérer les pré-requêtes OPTIONS
@app.after_request
def after_request(response):
    response.headers.add('Access-Control-Allow-Origin', 'http://localhost:8100')
    response.headers.add('Access-Control-Allow-Headers', 'Content-Type,Authorization')
    response.headers.add('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE,OPTIONS')
    response.headers.add('Access-Control-Allow-Credentials', 'true')
    return response

@app.route('/api/health', methods=['GET', 'OPTIONS'])
def health():
    if request.method == 'OPTIONS':
        return jsonify({}), 200
    return jsonify({
        'status': 'healthy',
        'port': 5100,
        'cors': 'enabled',
        'frontend': 'http://localhost:8100'
    })

@app.route('/api/generate', methods=['POST', 'OPTIONS'])
def generate():
    if request.method == 'OPTIONS':
        return jsonify({}), 200
    data = request.json or {}
    return jsonify({
        'status': 'success',
        'project_id': 'proj_cors_test',
        'message': 'CORS enabled backend',
        'data_received': data
    })

@app.route('/')
def index():
    return jsonify({'service': 'LLM-NAS CORS', 'port': 5100})

if __name__ == '__main__':
    print("🚀 Backend avec CORS sur port 5100")
    app.run(host='0.0.0.0', port=5200, debug=True)
