# Use an official PyTorch image as the base image
FROM nvidia/cuda:12.0.1-cudnn8-runtime-ubuntu22.04

# Set working directory
WORKDIR /app

COPY requirements.txt ./

# Install system dependencies
RUN apt-get update
RUN apt-get install -y \
    git \
    python3-pip \
    cuda-compiler-12-0

RUN uname -m
RUN python3 --version

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install --verbose -r requirements.txt

#RUN rm -rf /var/lib/apt/lists/*

COPY rp_warmup_sdxl_light_sdctrl.py ./
RUN python3 rp_warmup_sdxl_light_sdctrl.py

COPY *.py ./
COPY *.json ./
COPY *.png ./

CMD [ "python3", "-u", "rp_handler_sdxl_light_sdctrl.py" ]
