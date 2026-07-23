FROM python:3.12-slim

# Prevent Python from writing .pyc files and force stdout/stderr to be unbuffered
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    JUPYTER_TOKEN="alphadraft2026"

# Set working directory
WORKDIR /app

# Install essential C++ compilers for Networkit/Scikit-Learn dependencies,
# plus git (used to clone Meraki's lolstaticdata generator).
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential gcc g++ make git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Expose Jupyter port
EXPOSE 8888

# Bash shell by default
CMD ["/bin/bash"]