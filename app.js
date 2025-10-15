const express = require('express');
const app = express();
const port = 3000;




const hello = 'Hello from CI/CD on XNAsss';



app.get('/', (req, res) => res.send(hello));

app.listen(port, () => console.log(`App running on port ${port}`));
