FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Copy requirements first (for caching)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY service/ ./service/

# Copy config files
COPY .flaskenv .
COPY setup.cfg .
COPY Procfile .

# Expose port
EXPOSE 8080

# Set environment variables
ENV FLASK_APP=service:app
ENV PORT=8080

# Run the application
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "--access-logfile", "-", "service:app"]
