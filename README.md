# vscode.dev

Run vscode.dev locally, on-prem or on your cloud

## Build 

    docker build --platform linux/amd64 -t $USER/vscode.dev-amd64:latest .

## Run

    docker run -it --rm --memory="6gb" $USER/vscode.dev-amd64:latest

# Prebuilt Images

https://hub.docker.com/repository/docker/umrashrf/vscode.dev-arm64/general
