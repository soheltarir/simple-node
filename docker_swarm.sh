#!/bin/bash

echo "Script to manage running multiple Docker containers of simple-node application."
echo "Pick the action to continue:"
echo " [1] Start the container/s"
echo " [2] Stop the running container/s"
read -p "Please enter your numeric choice: " action

function start() {
    read -p "Number of containers: " container_count
    read -p "Starting Port: " start_port

    for (( i = 0; i < $container_count; i++ ))
    do
        let "port=$start_port + $i"
        echo "Starting container no. $i on port: $port"
        docker run --rm --name simple-node-$i -p $port:3000 -d soheltarir/simple-node:latest
    done
}

function stop() {
    echo "Stopping all running containers"
    docker stop $(docker ps | awk '{ if ($2 == "simple-node") { print $NF} }')
}

if [ $action -eq 1 ]
then
    start
elif [ $action -eq 2 ]
then
    stop
else
    echo Invalid choice provided.
fi
