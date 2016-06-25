{job} = require '../../jobs/get-current-track'

describe 'GetCurrentTrack', ->
  context 'when given a valid message', ->
    beforeEach (done) ->
      @connector =
        getCurrentTrack: sinon.stub().yields null, currentTrack: 'Oops I did it again'
      message = {}
      @sut = new job {@connector}
      @sut.do message, (@error, {@data, @metadata}) =>
        done()

    it 'should not error', ->
      expect(@error).not.to.exist

    it 'should call connector.getCurrentTrack', ->
      expect(@connector.getCurrentTrack).to.have.been.called

    it 'should return data', ->
      expect(@data.currentTrack).to.equal 'Oops I did it again'
