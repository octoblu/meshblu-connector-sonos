{job} = require '../../jobs/next'

describe 'Next', ->
  context 'when given a valid message', ->
    beforeEach (done) ->
      @connector =
        next: sinon.stub().yields null
      message = {}
      @sut = new job {@connector}
      @sut.do message, (@error) =>
        done()

    it 'should not error', ->
      expect(@error).not.to.exist

    it 'should call connector.next', ->
      expect(@connector.next).to.have.been.called
