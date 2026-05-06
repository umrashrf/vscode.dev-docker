FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y \
	&& apt install -y build-essential g++ git libsecret-1-dev libx11-dev libxkbfile-dev libkrb5-dev \
	&& apt install -y curl python3 python3-pip python3-virtualenv git

RUN git clone https://github.com/microsoft/vscode.git /vscode

WORKDIR /vscode

RUN virtualenv /vscode/venv

ENV PATH="/vscode/venv/bin:/usr/local/bin:$PATH"
RUN echo "export PATH=$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH" >> $HOME/.bashrc

RUN pip install -U pip

ENV NVM_DIR="/root/.nvm"
ENV NODE_VERSION="22.22.2"

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash

# 4. Use a single RUN command to load NVM and install Node
# Docker RUN uses /bin/sh by default; we force bash to source NVM correctly
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION && nvm use --delete-prefix $NODE_VERSION"

# 5. Add Node and NVM to the system PATH for future steps
ENV PATH="$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH"
RUN echo "export PATH=$NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH" >> $HOME/.bashrc

RUN npm install

# ENTRYPOINT can not be overwritten
ENTRYPOINT ["npm", "run"]

# CMD can be overwritten by docker run [...args]
CMD ["watch"]
