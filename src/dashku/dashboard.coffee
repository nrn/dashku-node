request = require 'request'

module.exports =

  getDashboards: (cb) =>
    apiUrl  = "http://localhost:3000"
    url     = "#{apiUrl}/api/dashboards?apiKey=#{@apiKey}"
    json    = true
    request.get {url, json}, (err,res,body) ->
      # TODO - track if response is successful or not
      cb body

  createDashboard: (attributes) ->
    console.log @
    "WAAA"