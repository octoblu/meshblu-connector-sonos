{job} = require '../../jobs/play'

describe 'Play', ->
  context 'when given a valid message', ->
    beforeEach (done) ->
      @connector =
        play: sinon.stub().yields null
      message = {}
      @sut = new job {@connector}
      @sut.do message, (@error) =>
        done()

    it 'should not error', ->
      expect(@error).not.to.exist

    it 'should call connector.play', ->
      expect(@connector.play).to.have.been.called
