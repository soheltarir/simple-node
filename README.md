# Simple Node App

A simple Node.js application that can be used for simple testing, e.g., load testing an infrastructure, API Gateways.
This application uses Express to expose simple User APIs. Random users are generated (using https://randomuser.me/) during server start.

## TL;DR
```
docker build -t simple-node .
docker run --rm --name simple-node -p 3000:3000 simple-node
```

## Running Multiple Containers

You can use the script `docker_swarm.sh` to manage running & stopping multiple containers.
```
./docker_swarm.sh
```
The above command will have interactive prompts for managing the containers.
