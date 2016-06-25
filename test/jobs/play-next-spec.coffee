{job} = require '../../jobs/play-next'

describe 'Play Next', ->
  context 'when given a valid message', ->
    beforeEach (done) ->
      @connector =
        playNext: sinon.stub().yields null
      message =
        data:
          uri: 'hi'
      @sut = new job {@connector}
      @sut.do message, (@error) =>
        done()

    it 'should not error', ->
      expect(@error).not.to.exist

    it 'should call connector.playNext', ->
      expect(@connector.playNext).to.have.been.calledWith uri: 'hi'

  context 'when given an invalid message', ->
    beforeEach (done) ->
      @connector = {}
      message = {}
      @sut = new job {@connector}
      @sut.do message, (@error) =>
        done()

    it 'should error', ->
      expect(@error).to.exist
