const express = require('express');
const app = express();
const port = 3000;




const hello = 'Hello from CI/CD: Diana Sena Kurnia';



app.get('/', (req, res) => res.send(hello));

app.listen(port, () => console.log(`App running on port ${port}`));
