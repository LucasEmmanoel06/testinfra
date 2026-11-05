FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Atualiza pacotes e instala dependências básicas do sistema, Python e cliente SSH
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv \
    openssh-client \
    sshpass \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Cria e ativa um ambiente virtual para instalação segura das ferramentas Python
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Instala Ansible Core, Pytest e pytest-testinfra
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir \
    ansible-core \
    pytest \
    pytest-testinfra

# Define o diretório de trabalho onde o volume será montado
WORKDIR /ansible

# Mantém o terminal interativo disponível
CMD ["/bin/bash"]