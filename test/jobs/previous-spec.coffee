{job} = require '../../jobs/previous'

describe 'Previous', ->
  context 'when given a valid message', ->
    beforeEach (done) ->
      @connector =
        previous: sinon.stub().yields null
      message = {}
      @sut = new job {@connector}
      @sut.do message, (@error) =>
        done()

    it 'should not error', ->
      expect(@error).not.to.exist

    it 'should call connector.previous', ->
      expect(@connector.previous).to.have.been.called
