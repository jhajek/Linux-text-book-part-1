// Simple sample app from
// http://expressjs.com/en/starter/hello-world.html
// You can access this by opening a webbrowser on your Virtual Machine
// from the directory where the app.js is located run: node app.js
// and go to http://127.0.0.1:3000
const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => {
res.send('Hello World!')
})

app.listen(port, () => {
console.log(`Example app listening at http://localhost:${port}`)
})
