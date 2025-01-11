# Base image
FROM --platform=linux/arm64/v8 ubuntu:22.04

# Set Label
LABEL maintainer="Kailash Lohar <kailashlohariitkgp@gmail.com>"

# Set Working Directory
WORKDIR /home

# Install Utilities & Miniconda Conda Environment
RUN apt-get update && apt-get install -y make cmake wget unzip curl git gcc g++ python3 python3-pip \
    libboost-system-dev libboost-thread-dev libboost-serialization-dev libboost-filesystem-dev libboost-program-options-dev libboost-timer-dev libx11-dev libxrender-dev \
    pkg-config libhdf5-dev && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh -O miniconda.sh && \
    bash miniconda.sh -b -p /miniconda && rm miniconda.sh && rm -rf /var/lib/apt/lists/*
ENV PATH /miniconda/bin:$PATH
COPY streamlit.yaml .
RUN conda env create -f streamlit.yaml && conda clean --all --yes 

WORKDIR /home

# Expose Streamlit Port
EXPOSE 8501

ENTRYPOINT ["conda", "run", "-n", "streamlit_env", "streamlit", "run", "main.py", "--server.port", "8501", "--server.headless", "true", "--theme.base", "light"]
