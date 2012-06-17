assert    = require 'assert'
dashku    = require '../src/dashku'

describe 'Dashku', ->

  describe 'setApiKey', ->

    it 'should set the api key for the library', ->

      key = 'a-random-key'
      dashku.setApiKey key, ->
        assert.equal dashku.apiKey, key
