FROM python:3.8-slim-buster

# Create virtual environment (before copying files for efficiency)
RUN python -m venv /opt/venv

# Set working directory
WORKDIR /app

# Copy requirements and application code
COPY requirements.txt .
COPY . .

# Install dependencies within the virtual environment
RUN /opt/venv/bin/pip install -r requirements.txt

# Use virtual environment's Python directly in CMD
CMD ["/opt/venv/bin/python", "app.py"]
