{job} = require '../../jobs/play-immediately'

describe 'Play Immediately', ->
  context 'when given a valid message', ->
    beforeEach (done) ->
      @connector =
        playImmediately: sinon.stub().yields null
      message =
        data:
          uri: 'hi'
      @sut = new job {@connector}
      @sut.do message, (@error) =>
        done()

    it 'should not error', ->
      expect(@error).not.to.exist

    it 'should call connector.playImmediately', ->
      expect(@connector.playImmediately).to.have.been.calledWith uri: 'hi'

  context 'when given an invalid message', ->
    beforeEach (done) ->
      @connector = {}
      message = {}
      @sut = new job {@connector}
      @sut.do message, (@error) =>
        done()

    it 'should error', ->
      expect(@error).to.exist
