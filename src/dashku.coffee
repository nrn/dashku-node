request         = require 'request'
@apiUrl         = "https://localhost" 

# Sets the api key used by the client
exports.setApiKey = (value, cb=null) ->
  @apiKey = value
  cb() if cb?

# returns all of the user's dashboards
exports.getDashboards = (cb) ->
  url     = "#{@apiUrl}/api/dashboards?apiKey=#{@apiKey}"
  json    = true
  request.get {url, json}, (err,res,body) ->
    if res.statusCode is 200
      cb status: 'success', dashboards: body
    else
      cb body

# returns a dashboard
exports.getDashboard = (id, cb) ->
  url     = "#{@apiUrl}/api/dashboards/#{id}?apiKey=#{@apiKey}"
  json    = true
  request.get {url, json}, (err,res,body) ->
    if res.statusCode is 200
      cb status: 'success', dashboard: body
    else
      cb body

# creates a dashboard
exports.createDashboard = (data, cb=null) ->
  url     = "#{@apiUrl}/api/dashboards?apiKey=#{@apiKey}"
  body    = JSON.stringify data
  json    = true
  request.post {url, body, json}, (err,res,body) ->
    if res.statusCode is 202
      cb status: 'success', dashboard: body
    else
      cb body

# updates a dashboard
exports.updateDashboard = (data, cb=null) ->
  url     = "#{@apiUrl}/api/dashboards/#{data._id}?apiKey=#{@apiKey}"
  body    = JSON.stringify data
  json    = true
  request.put {url, body, json}, (err,res,body) ->
    if res.statusCode is 201
      cb status: 'success', dashboard: body
    else
      cb body

# deletes a dashboard
exports.deleteDashboard = (dashboardId, cb=null) ->
  url     = "#{@apiUrl}/api/dashboards/#{dashboardId}?apiKey=#{@apiKey}"
  json    = true
  request.del url, (err,res,body) ->
    if res.statusCode is 201
      cb status: 'success', dashboardId: body
    else
      cb JSON.parse body

# creates a widget
exports.createWidget = (attributes, cb=null) ->
  url     = "#{@apiUrl}/api/dashboards/#{attributes.dashboardId}/widgets?apiKey=#{@apiKey}"
  json    = true
  body    = JSON.stringify attributes
  request.post {url, body, json}, (err,res,body) ->
    if res.statusCode is 202
      cb status: 'success', widget: body
    else
      cb body

# updates a widget
exports.updateWidget = (attributes, cb=null) ->
  url     = "#{@apiUrl}/api/dashboards/#{attributes.dashboardId}/widgets/#{attributes._id}?apiKey=#{@apiKey}"
  body    = JSON.stringify attributes
  json    = true
  request.put {url, body, json}, (err,res,body) ->
    if res.statusCode is 201
      cb status: 'success', widget: body
    else
      cb body

# deletes a widget
exports.deleteWidget = (dashboardId, widgetId, cb=null) ->
  url     = "#{@apiUrl}/api/dashboards/#{dashboardId}/widgets/#{widgetId}?apiKey=#{@apiKey}"
  json    = true
  request.del url, (err,res,body) ->
    if res.statusCode is 201
      cb status: 'success', widgetId: body
    else
      cb JSON.parse body