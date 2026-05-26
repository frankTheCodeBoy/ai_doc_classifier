# AI Resume Classifier

A lightweight local resume classification and analysis app for developers and product teams who want to explore resume intake, categorization, and basic AI-assisted scoring without introducing a heavyweight backend framework.

## Overview

This project combines a FastAPI backend, a Streamlit frontend, and a simple local training workflow.

### What the app does

- Accepts PDF resume uploads from the UI
- Extracts resume text from PDF files
- Classifies resumes using a trained local model
- Produces a lightweight AI analysis payload with:
  - category
  - summary
  - skills
  - recommended roles
  - strengths
  - score
- Saves analysis results locally in SQLite for later review

### What the app is not

- It is **not** a production-ready document processing platform.
- It is **not** a general-purpose LLM service.
- It is **not** a full multi-user SaaS deployment.

## Project structure

- `api/main.py` – FastAPI backend and API routes
- `ui/app.py` – Streamlit user interface
- `scripts/train_classifier.py` - training pipeline
- `scripts/register_training_samples.py` - CLI helper for adding training data
- `data/raw/` - labeled sample resumes
- `data/training_manifest.json` - source of truth for training labels
- `models/` - persisted classifier assets
- `utils/` - document extraction and text cleaning helpers
- `docs/DEVELOPER_GUIDE.md` - developer-focused setup and workflow instructions

## Requirements

- Python 3.11
- Windows PowerShell
- `pip`

Install dependencies:

```powershell
python -m venv .venv
.\.venv\Scripts\activate
pip install -r requirements.txt
```

## Run the application

### Start the backend

```powershell
.\.venv\Scripts\python api/main.py
```

The backend listens on `http://127.0.0.1:8000`.

### Start the Streamlit UI

```powershell
.\.venv\Scripts\streamlit run ui/app.py --server.headless true --server.port 8501
```

Open `http://localhost:8501` in your browser.

## Environment variables

The app uses a small set of optional environment variables:

- `CLASSIFY_API_URL` – override the classify endpoint
- `ANALYZE_API_URL` – override the analyze endpoint
- `ALLOWED_ORIGINS` – whitelist UI origins for CORS

A `.env` file at the project root is supported.

## How the app works

1. The UI uploads a resume PDF.
2. The backend extracts the text from the PDF.
3. A local TF-IDF + logistic regression classifier predicts the category.
4. A lightweight rule-based analysis layer extracts skills, strengths, recommended roles, and a score.
5. The result is returned to the UI and stored in the local SQLite history database.

## Training workflow

The notebook is optional and is **not required** to retrain the model.

### Add and register new training samples

```powershell
python scripts/register_training_samples.py data/raw/your_resume.pdf --category YourCategory
```

### Register and retrain in one step

```powershell
python scripts/register_training_samples.py data/raw/your_resume.pdf --category YourCategory --retrain
```

### Retrain directly

```powershell
python scripts/train_classifier.py
```

The training manifest lives in `data/training_manifest.json`. The manifest is the source of truth for labeled training data.

## Data and model artifacts

- `data/raw/` contains the labeled resume samples used for training.
- `data/training_manifest.json` maps filenames to categories.
- `models/resume_classifier.pkl` stores the trained classifier.
- `models/vectorizer.pkl` stores the fitted vectorizer.

## Current limits and practical notes

- The UI currently accepts **PDF uploads only**.
- The classifier is a lightweight local model and is best suited for a **curated set of categories**.
- The analysis layer is **rule-based** and should be treated as a helpful scoring aid, not a definitive hiring signal.
- The app is intended for **local development and experimentation**, not production deployment.
- The current workflow does **not** include authentication, user accounts, or cloud storage.

## Developer documentation

For setup, startup, troubleshooting, and training details, see:

- `docs/DEVELOPER_GUIDE.md`

## Troubleshooting

- If the backend cannot start, confirm you are running from the project root and that your virtual environment is active.
- If the UI cannot reach the API, confirm the backend is running on `http://127.0.0.1:8000` and that `ALLOWED_ORIGINS` includes `http://localhost:8501`.
- If a new resume is not affecting predictions, confirm it is registered in `data/training_manifest.json` and retrain the model.
- If the classifier still returns old labels after adding samples, rerun `python scripts/train_classifier.py` and restart the backend.
- If you receive a PDF extraction error, confirm the file is a valid PDF and not an unsupported document type.
- If you want to validate the backend manually, open `http://127.0.0.1:8000/` and then test `/classify` with a sample resume.

## Quick start

```powershell
python -m venv .venv
.\.venv\Scripts\activate
pip install -r requirements.txt
.\.venv\Scripts\python api/main.py
.\.venv\Scripts\streamlit run ui/app.py --server.headless true --server.port 8501
```
