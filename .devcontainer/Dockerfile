FROM ubuntu:latest

# Set environment variables to non-interactive (this prevents some prompts)
ENV DEBIAN_FRONTEND=non-interactive

# Run package updates, install packages, and clean up
RUN apt-get update -y \
    # Install common packages and openssh-client
    && apt-get install -y \
        ca-certificates \
        curl \
        gnupg \
        openssh-client \
        python3 \
        make \
    # Add Google Cloud SDK repo and its key
    && echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - \
    && apt-get update \
    && apt-get install -y google-cloud-sdk \
    # Remove unnecessary files
    && rm -rf /var/lib/apt/lists/* \
    # Generate SSH Key
    && ssh-keygen -t rsa -b 4096 -f /root/.ssh/id_rsa -N ""

WORKDIR /automation
COPY . /automation/