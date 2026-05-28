# Base image
FROM python:3.11

# Prevent .pyc files and enable unbuffered logs
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install Python dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Set working directory
WORKDIR /app
COPY . /app

# Ensure Python can import from /app
ENV PYTHONPATH=/app

# Copy startup script and set permissions as root
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Create non-root user and switch
RUN adduser -u 5678 --disabled-password --gecos "" appuser && chown -R appuser /app
USER appuser

# Run both FastAPI + Streamlit
CMD ["/start.sh"]
