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
