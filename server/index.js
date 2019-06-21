const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const keys = require('./config/keys')
const passport = require('passport');
const axios = require('axios')
const router = require('express').Router();
require('./models/User');
require('./services/passport');


mongoose.connect(keys.mongoURI);

const app = express();

app.use(bodyParser.json()); //express doesn't automatically parse the body of objects, so we need this module.

app.use(passport.initialize());
app.use(passport.session());

require('./routes/authRoutes')(app);
require('./routes/photoRoutes')(app)


const PORT = process.env.PORT || 5000
app.listen(PORT);

