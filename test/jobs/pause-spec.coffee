{job} = require '../../jobs/pause'

describe 'Pause', ->
  context 'when given a valid message', ->
    beforeEach (done) ->
      @connector =
        pause: sinon.stub().yields null
      message = {}
      @sut = new job {@connector}
      @sut.do message, (@error) =>
        done()

    it 'should not error', ->
      expect(@error).not.to.exist

    it 'should call connector.pause', ->
      expect(@connector.pause).to.have.been.called
