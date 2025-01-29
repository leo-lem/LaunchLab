# Chatpreneur Web API

## Requirements

1. Docker + Docker desktop installed and running
2. Postman or similar application installed

## Usage

### Step 1: Run Docker compose

```sh
docker-compose -p chatpreneur up
```

### Step 2: Open Website

1. Open Docker desktop and navigate to `Containers`
2. Click on the port of the `chatpreneur-api` container
3. Navigate in your browser to `/chat-widget`
4. **Have fun using our chat widget!!!**

### Step 3: Start Tailwind watcher (When developing)

```sh
.\tailwindcss-windows-x64.exe -i static/input.css -o static/output.css --watch
```

### Step 4: Minify Tailwind (When starting in production)

```sh
./tailwindcss-windows-x64.exe -i static/input.css -o static/output.css --minify
```

## Usage as REST API

### Step 1: Follow steps of [Usage](#usage)

### Step 2: Connect to API

1. Open Docker desktop and navigate to `Containers`
2. Open Postman or a similar application to use a REST API and connect to the IP address and Port provided by Docker
3. For the endpoint use `/chat`

### Step 3: Send message to chat bot

Send your message in the body of your response with the following format:

```JSON
{
    "message": "YOUR MESSAGE GOES HERE"
}
```
