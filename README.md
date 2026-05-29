# AI Resume Classifier 📄

A production-ready AI-powered resume classification system built with FastAPI, Streamlit, and Docker. Uses machine learning and Hugging Face for intelligent resume analysis and role recommendations.

![Tests](https://github.com/frankTheCodeBoy/ai_doc_classifier/actions/workflows/tests.yml/badge.svg)
![Python](https://img.shields.io/badge/Python-3.11-blue)
![Docker](https://img.shields.io/badge/Docker-Ready-brightgreen)
![License](https://img.shields.io/badge/License-MIT-green)

## 🎯 Features

- **Resume Classification**: Automatically categorize resumes (Tech, Finance, Healthcare, Education)
- **AI-Powered Analysis**: Extract skills, strengths, and role recommendations using Hugging Face
- **Resume Scoring**: Intelligent scoring system based on keywords and role alignment
- **Web UI**: User-friendly Streamlit interface for uploading and analyzing resumes
- **REST API**: FastAPI backend with comprehensive documentation
- **Authentication**: Secure API key-based authentication
- **Docker Ready**: One-command deployment with Docker Compose
- **Free Hosting**: Deploy free on GitHub Codespaces (60h/month)

## 🚀 Quick Start

### Prerequisites
- Docker & Docker Compose
- Python 3.11+
- Hugging Face API Key (free at https://huggingface.co/settings/tokens)

### Local Development

1. **Clone Repository**
   ```bash
   git clone https://github.com/frankTheCodeBoy/ai_doc_classifier.git
   cd ai_doc_classifier
   ```

2. **Create Environment File**
   ```bash
   cp .env.example .env
   # Edit .env and add your Hugging Face token
   ```

3. **Start with Docker Compose**
   ```bash
   docker compose up -d
   ```

4. **Access Applications**
   - **Streamlit UI**: http://localhost:8502
   - **Backend API**: http://localhost:8002
   - **API Docs**: http://localhost:8002/docs

5. **Run Tests**
   ```bash
   docker compose exec resume-prod pytest -v
   ```

## 📊 Architecture

```
┌─────────────────────────────────────────┐
│         Streamlit Frontend              │
│      (http://localhost:8502)            │
└────────────────┬────────────────────────┘
                 │
                 │ HTTP Requests
                 ▼
┌─────────────────────────────────────────┐
│    FastAPI Backend (api/main.py)        │
│   ├─ POST /classify - Fast classification
│   ├─ POST /analyze - Full AI analysis
│   └─ GET / - Health check
└────────────────┬────────────────────────┘
                 │
        ┌────────┴────────┬──────────────┐
        ▼                 ▼              ▼
   ┌─────────┐    ┌──────────────┐  ┌──────────┐
   │  Local  │    │  Hugging     │  │ SQLite  │
   │   ML    │    │  Face API    │  │   DB    │
   │ Models  │    │ (BART)       │  │         │
   └─────────┘    └──────────────┘  └──────────┘
```

## 🗂️ Project Structure

```
ai_doc_classifier/
├── api/
│   └── main.py                 # FastAPI application
├── ui/
│   └── app.py                  # Streamlit frontend
├── utils/
│   ├── extract.py              # PDF text extraction
│   ├── preprocess.py           # Text preprocessing
│   └── huggingface_utils.py    # HF integration
├── tests/
│   ├── test_api.py             # API endpoint tests
│   ├── test_auth.py            # Authentication tests
│   ├── test_resumes.py         # Resume tests
│   └── test_train_classifier.py# Classifier tests
├── models/
│   ├── resume_classifier.pkl   # Trained classifier
│   └── vectorizer.pkl          # Feature vectorizer
├── Dockerfile                  # Container configuration
├── docker-compose.yml          # Multi-service setup
├── requirements.txt            # Python dependencies
└── .env                        # Environment variables

```

## 🔧 Environment Variables

```env
# API Configuration
BACKEND_API_KEY=changeme123
ALLOWED_ORIGINS=http://localhost:8501,http://127.0.0.1:8501

# URLs
CLASSIFY_API_URL=http://localhost:8000/classify
ANALYZE_API_URL=http://localhost:8000/analyze

# AI Integration
HUGGINGFACE_API_KEY=hf_your_token_here
```

## 📡 API Endpoints

### Classify Resume (Fast)
```bash
POST /classify
Headers: X-API-Key: changeme123
Body: multipart/form-data (file: resume.pdf)

Response:
{
  "category": "tech",
  "source": "local"
}
```

### Analyze Resume (Full AI)
```bash
POST /analyze
Headers: X-API-Key: changeme123
Body: multipart/form-data (file: resume.pdf)

Response:
{
  "category": "tech",
  "summary": "AI-generated summary...",
  "skills": ["python", "sql", "aws"],
  "recommended_roles": ["Software Engineer", "Data Analyst"],
  "strengths": ["leadership", "execution"],
  "score": 78.5,
  "source": "local"
}
```

### Health Check
```bash
GET /
Headers: X-API-Key: changeme123

Response:
{
  "status": "ok",
  "service": "resume classifier"
}
```

## 🧪 Testing

Run all tests:
```bash
docker compose exec resume-prod pytest -v
```

Run specific test file:
```bash
docker compose exec resume-prod pytest tests/test_auth.py -v
```

Run with coverage:
```bash
docker compose exec resume-prod pytest --cov=. tests/
```

**Current Status**: ✅ 12/12 tests passing

## 🌐 Deployment

### GitHub Codespaces (Recommended - Free 60h/month)
```bash
# 1. Go to GitHub repo
# 2. Click "Code" → "Codespaces" → "Create"
# 3. In terminal: docker compose up -d
# 4. Click port 8501 link
```
📖 Guide: [docs/DEPLOYMENT_GITHUB_CODESPACES.md](docs/DEPLOYMENT_GITHUB_CODESPACES.md)

### Replit (Alternative - Free forever)
📖 Guide: [docs/DEPLOYMENT_REPLIT.md](docs/DEPLOYMENT_REPLIT.md)

### DigitalOcean ($200 Student Credit)
📖 Guide: [docs/ARCHIVED_DIGITALOCEAN_GUIDE.md](docs/ARCHIVED_DIGITALOCEAN_GUIDE.md)

## 🔐 Security

- API key authentication on all endpoints
- CORS configuration for safe cross-origin requests
- Non-root user in Docker container
- Environment-based secrets management
- Input validation on file uploads

## 📈 Performance

- **Classification**: ~200ms per resume
- **Full Analysis**: ~500ms per resume (with HF API)
- **Concurrent Requests**: 10+ simultaneous
- **Memory Usage**: ~400MB per instance
- **Storage**: 1GB for models + logs

## 🤝 Contributing

1. Fork repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

## 📝 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file for details.

## 👤 Author

**Francis Olum**
- GitHub: [@frankTheCodeBoy](https://github.com/frankTheCodeBoy)
- Role: Analytics Engineer & Open-Source Advocate

## 🙏 Acknowledgments

- FastAPI for the modern web framework
- Streamlit for easy UI development
- Hugging Face for AI models
- Docker for containerization
- GitHub Student Pack for free resources

## 📞 Support

- 📖 Full documentation: [docs/](docs/)
- 🐛 Bug reports: [GitHub Issues](https://github.com/frankTheCodeBoy/ai_doc_classifier/issues)
- 💬 Questions: Open a discussion

## 📊 Statistics

- **Tests**: 12 passing ✅
- **Coverage**: Core functionality
- **Python Version**: 3.11
- **Dependencies**: 25+ packages
- **Docker Layers**: 8 optimized layers
- **Lines of Code**: ~2000

---

**Made with ❤️ by Francis Olum**

⭐ If this project helped you, please consider starring it!
