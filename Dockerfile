# Use an official PyTorch image as the base image
FROM nvidia/cuda:12.0.1-cudnn8-runtime-ubuntu22.04

# Set working directory
WORKDIR /app

RUN apt-get update
RUN apt-get install -y \
    git \
    python3-pip \
    cuda-compiler-12-0

RUN uname -m
RUN python3 --version

# Install Python dependencies
COPY requirements.txt ./
RUN pip install --upgrade pip && \
    pip install --verbose -r requirements.txt

#RUN rm -rf /var/lib/apt/lists/*

COPY init ./
RUN ./init

WORKDIR /app/source

COPY requirements-torch-adapter.txt ./
RUN pip install --verbose -r requirements-torch-adapter.txt

RUN ./init

CMD [ "/bin/bash", "start" ]
