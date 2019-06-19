const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth20').Strategy;
const mongoose = require('mongoose')
const keys = require('../config/keys');
const User = mongoose.model('users'); // one argument to retreive, two to load.

// mongoose.connect("process.env.MONGO_URI", { useNewUrlParser: true })
//     .then(() => console.log('Connecting to mongodb'))
//     .catch((error) => console.log(error))

passport.serializeUser((user, done) => {
    done(null, user.id);
});

passport.deserializeUser((id, done) => {
    User.findById(id)
    .then(user => {
        done(null, user);
    });
});

passport.use(new GoogleStrategy({
    clientID: keys.googleClientID,
    clientSecret: keys.googleClientSecret,
    callbackURL: '/auth/google/callback',
    proxy: true
    }, 
    async (accessToken, refreshToken, profile, done) => {
        const existingUser = await User.findOne({googleId: profile.id});
            if(existingUser) {
                return done(null, existingUser);
            } 
            const user = await new User({ googleId: profile.id }).save();
            done(null, user);   
        } 
    )
);     