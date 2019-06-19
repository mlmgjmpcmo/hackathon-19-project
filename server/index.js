const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');

mongoose.connect(keys.mongoURI);

const app = express();

app.use(bodyParser.json()); //express doesn't automatically parse the body of objects, so we need this module.

const PORT = process.env.PORT || 5000
app.listen(PORT);

