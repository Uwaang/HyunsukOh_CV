# docker build -t uwaang/cv_image:1.0 --build-arg UID=$UID --build-arg USER_NAME=$USER -f Dockerfile .
# docker run -it --name cv_cont01 -v $PWD:/home/$USER/cv -w /home/$USER/cv uwaang/cv_image:1.0

FROM ubuntu:latest
LABEL maintainer "https://github.com/Uwaang"

ARG UID=1000
ARG USER_NAME=user
ARG PYTHON_VERSION=3.8
ARG CONDA_ENV_NAME=cv

ENV DEBIAN_FRONTEND=noninteractive

# Needed for string substitution
SHELL ["/bin/bash", "-c"]
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    ccache \
    cmake \
    curl \
    git \
    libfreetype6-dev \
    libhdf5-serial-dev \
    libzmq3-dev \
    libjpeg-dev \
    libpng-dev \
    libsm6 \
    libxext6 \
    libxrender-dev \
    pkg-config \
    software-properties-common \
    sudo \
    vim \
    wget \
    openssh-server \
    texlive-full \
    poppler-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV LANG C.UTF-8
RUN curl -o /tmp/miniconda.sh -sSL http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    chmod +x /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -bfp /usr/local && \
    rm /tmp/miniconda.sh
RUN conda config --add channels conda-forge && \
    conda config --remove channels defaults && \
    conda install mamba && \
    mamba update -y conda

# Create a user
RUN adduser $USER_NAME -u $UID --quiet --gecos "" --disabled-password && \
    echo "$USER_NAME ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USER_NAME && \
    chmod 0440 /etc/sudoers.d/$USER_NAME

# For connecting via ssh
RUN echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config && \
    echo "PermitEmptyPasswords yes" >> /etc/ssh/sshd_config && \
    echo "UsePAM no" >> /etc/ssh/sshd_config

USER $USER_NAME
SHELL ["/bin/bash", "-c"]

# Create the conda environment
RUN conda create -n $CONDA_ENV_NAME python=$PYTHON_VERSION
ENV PATH /usr/local/envs/$CONDA_ENV_NAME/bin:$PATH
RUN echo "source activate ${CONDA_ENV_NAME}" >> ~/.bashrc

# Enable jupyter lab
RUN source activate ${CONDA_ENV_NAME} && \
    conda config --add channels conda-forge && \
    conda config --remove channels defaults && \
    conda install mamba && \
    mamba update -y conda && \
    mamba install pdf2image pillow