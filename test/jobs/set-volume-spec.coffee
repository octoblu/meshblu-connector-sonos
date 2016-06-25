{job} = require '../../jobs/set-volume'

describe 'SetVolume', ->
  context 'when given a valid message', ->
    beforeEach (done) ->
      @connector =
        setVolume: sinon.stub().yields null
      message =
        data:
          volume: 'hi'
      @sut = new job {@connector}
      @sut.do message, (@error) =>
        done()

    it 'should not error', ->
      expect(@error).not.to.exist

    it 'should call connector.setVolume', ->
      expect(@connector.setVolume).to.have.been.calledWith volume: 'hi'

  context 'when given an invalid message', ->
    beforeEach (done) ->
      @connector = {}
      message = {}
      @sut = new job {@connector}
      @sut.do message, (@error) =>
        done()

    it 'should error', ->
      expect(@error).to.exist
