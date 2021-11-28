const express = require('express');
const https = require('https');
const _ = require('lodash');

const app = express();
const serverPort = parseInt(process.env.SERVER_PORT) || 3000;

// In-memory database of users, populated on start of server start
let USER_DATABASE = [];

const populateUsers = () => {
    https.get('https://randomuser.me/api/?results=3&inc=gender,name,email,login', (res) => {
        let data = '';
        // A chunk of data has been received.
        res.on('data', (chunk) => {
            data += chunk;
        });

        res.on('end', () => {
            USER_DATABASE = JSON.parse(data).results;
        });
    }).on("error", (err) => {
        console.log(`Failed to populate users, error: ${err}`);
        process.exit(2);
    })
}

// Routes
app.get('/', (req, res) => {
    res.json({status: "OK"});
})

app.get('/users', (req, res) => {
    res.json(USER_DATABASE);
})

app.get('/user/:userId', (req, res) => {
    const query = req.params.userId;
    const user = _.find(USER_DATABASE, function(o) {
        return o.login.uuid === query; 
    });
    if (user) {
        res.json(user);
    } else {
        res.status(404).json({message: "No user found"});
    }
})

app.listen(serverPort, () => {
    populateUsers();
    console.log(`Server running at http://0.0.0.0:${serverPort}.`);
})
