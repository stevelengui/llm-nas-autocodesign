# 🚀 LLM-NAS AutoCoDesign

**Automatic Algorithm-Architecture Co-Design Platform with Strict Compliance**

## 📋 Overview

LLM-NAS AutoCoDesign automatically generates optimized embedded systems with **3 strict academic requirements**:

1. **HW-SW Codesign Exploration** - Pareto frontier multi-objective optimization
2. **Explainable Model Integration** - SHAP/LIME for design traceability
3. **Meta-Learning Robustness** - MAML for cross-domain generalization

## 🏗️ Architecture
llm-nas-autocodesign/
├── backend/ # Flask API
├── frontend/ # Web interface
├── llm_nas/ # Core modules (3 requirements)
├── examples/ # Demo projects
└── docs/ # Documentation

text

## 🚀 Quick Start

```bash
# Clone repository
git clone https://github.com/stevelengui/llm-nas-autocodesign.git
cd llm-nas-autocodesign

# Install dependencies
pip install -r requirements.txt

# Start backend
cd backend && python backend.py &

# Start frontend (in another terminal)
cd ../frontend && python3 -m http.server 8080 &

# Open browser
# http://localhost:8080
🔬 Reproducibility
The source code, pre-trained models, and comprehensive documentation are available at
https://github.com/stevelengui/llm-nas-autocodesign
to facilitate adoption and further research.

📄 License
MIT License - see LICENSE file.
