const axios = require('axios')
const { url }= require('../baseURL') ;


module.exports = (app) => {
  app.get('/api/user/photos', (req, res) => {

  const getPhotoThumbnail = () => {
    return axios.get(`${url}IMG_0559.JPG?kind=thumbnail`)
                .then(response => {
                  return response.data
                }).catch(err => {
                    console.log(err)
                })
  }

  getPhotoThumbnail().then(data => {
    res.send(data)
  })

})

}

