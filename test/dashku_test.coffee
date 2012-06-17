assert    = require 'assert'
request   = require 'request'
dashku    = require '../src/dashku'

apiKey    = "c19cabb2-85d6-4be0-b1d6-d85a19b8245e"

describe 'Dashku', ->

  describe 'setApiKey', ->

    it 'should set the api key for the library', (done) ->

      key = 'a-random-key'
      dashku.setApiKey key, ->
        assert.equal dashku.apiKey, key
        done()

  describe 'getDashboards()', ->

    it "should return an array of dashboard objects", (done) ->

      dashku.setApiKey apiKey, ->
        dashku.getDashboards (response) ->
          assert.equal response.status, 'success'
          assert response.dashboards instanceof Array
          done()

    it "should throw an error if the response fails", (done) ->

      dashku.setApiKey "waa", ->
        dashku.getDashboards (response) ->
          assert.equal response.status, 'failure'
          assert.equal response.reason, "Couldn't find a user with that API key"
          done()

  describe 'getDashboard()', ->

    it "should return a dashboard object, given an id", (done) ->
      dashku.setApiKey apiKey, ->
        dashku.getDashboards (response) ->
          dashboardId = response.dashboards[0]._id
          dashku.getDashboard dashboardId, (response) ->
            assert.equal response.status, 'success'
            assert response.dashboard instanceof Object
            done()

    it "should throw an error if the response fails", (done) ->
      dashku.setApiKey apiKey, ->
        dashboardId = "rubbish"
        dashku.getDashboard dashboardId, (response) ->
          assert.equal response.status, 'failure'
          assert.equal response.reason, "Dashboard not found"
          done()

  describe 'createDashboard()', ->

    it "should return a dashboard object, given attributes", (done) ->
      dashku.setApiKey apiKey, ->
        attributes = 
          name: "My new dashboard"
        dashku.createDashboard attributes, (response) ->
          assert.equal response.status, 'success'
          assert response.dashboard instanceof Object
          assert.equal response.dashboard.name, attributes.name
          done()

    it "should throw an error if the response fails", (done) ->
      dashku.setApiKey "waa", ->
        attributes = 
          name: "My new dashboard"
        dashku.createDashboard attributes, (response) ->
          assert.equal response.status, 'failure'
          assert.equal response.reason, "Couldn't find a user with that API key"
          done()

  describe "updateDashboard()", ->

    it "should return a dashboard object, given attributes", (done) ->
      dashku.setApiKey apiKey, ->
        dashku.getDashboards (response) ->
          dashboardId = dashboard._id for dashboard in response.dashboards when dashboard.name is "My new dashboard"        
          attributes =
            _id: dashboardId
            name: "ZZZ dashboard"
          dashku.updateDashboard attributes, (response) ->
            assert.equal response.status, 'success'
            assert response.dashboard instanceof Object
            assert.equal response.dashboard.name, attributes.name
            done()

    it "should throw an error if the response fails", (done) ->
      attributes =
        _id: "Rubbish"
        name: "ZZZ dashboard"
      dashku.updateDashboard attributes, (response) ->
        assert.equal response.status, 'failure'
        assert.equal response.reason, "Dashboard not found"
        done()

  describe "deleteDashboard()", ->

    it "should return the id of the deleted dashboard", (done) ->
      dashku.getDashboards (response) ->
        dashboardId = dashboard._id for dashboard in response.dashboards when dashboard.name is "ZZZ dashboard"        
        dashku.deleteDashboard dashboardId, (response) ->
          assert.equal response.status, 'success'
          assert.equal response.dashboardId, JSON.stringify dashboardId
          done()

    it "should throw an error if the response fails", (done) ->
      dashku.deleteDashboard "Rubbish", (response) ->
        assert.equal response.status, 'failure'
        assert.equal response.reason, "Dashboard not found"
        done()