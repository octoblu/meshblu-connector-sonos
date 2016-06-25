{job} = require '../../jobs/mute'

describe 'Mute', ->
  context 'when given a valid message', ->
    beforeEach (done) ->
      @connector =
        mute: sinon.stub().yields null
      message = {}
      @sut = new job {@connector}
      @sut.do message, (@error) =>
        done()

    it 'should not error', ->
      expect(@error).not.to.exist

    it 'should call connector.mute', ->
      expect(@connector.mute).to.have.been.called
