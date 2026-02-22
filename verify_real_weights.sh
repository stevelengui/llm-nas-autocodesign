# verify_real_weights.sh
#!/bin/bash

echo "🔍 VÉRIFICATION DES VRAIS POIDS INTÉGRÉS"

cd ~/LLMNAS_Corrected

# Tester l'API
echo "1. Test API..."
curl -s http://localhost:5000/api/health | python3 -m json.tool

echo ""
echo "2. Générer un projet avec vrais poids..."
curl -X POST http://localhost:5000/api/generate/real \
  -H "Content-Type: application/json" \
  -d '{
    "domain": "medical",
    "mcu": "riscv",
    "latency": 20,
    "memory": 64,
    "power": 50
  }' | python3 -m json.tool

echo ""
echo "3. Vérifier les statistiques des poids..."
curl -s http://localhost:5000/api/weights/stats | python3 -m json.tool

echo ""
echo "4. Vérifier les fichiers générés..."
LAST_PROJ=$(ls -t generated_projects/ | head -1)
echo "📁 Dernier projet: $LAST_PROJ"
ls -la "generated_projects/$LAST_PROJ/"
