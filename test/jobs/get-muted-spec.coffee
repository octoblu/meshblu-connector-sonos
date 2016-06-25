{job} = require '../../jobs/get-muted'

describe 'GetMuted', ->
  context 'when given a valid message', ->
    beforeEach (done) ->
      @connector =
        getMuted: sinon.stub().yields null, muted: 'Oops I did it again'
      message = {}
      @sut = new job {@connector}
      @sut.do message, (@error, {@data, @metadata}) =>
        done()

    it 'should not error', ->
      expect(@error).not.to.exist

    it 'should call connector.getMuted', ->
      expect(@connector.getMuted).to.have.been.called

    it 'should return data', ->
      expect(@data.muted).to.equal 'Oops I did it again'
