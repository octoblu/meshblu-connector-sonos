{job} = require '../../jobs/unmute'

describe 'Unmute', ->
  context 'when given a valid message', ->
    beforeEach (done) ->
      @connector =
        unmute: sinon.stub().yields null
      message = {}
      @sut = new job {@connector}
      @sut.do message, (@error) =>
        done()

    it 'should not error', ->
      expect(@error).not.to.exist

    it 'should call connector.unmute', ->
      expect(@connector.unmute).to.have.been.called
