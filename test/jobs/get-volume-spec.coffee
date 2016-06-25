{job} = require '../../jobs/get-volume'

describe 'GetVolume', ->
  context 'when given a valid message', ->
    beforeEach (done) ->
      @connector =
        getVolume: sinon.stub().yields null, volume: 'Oops I did it again'
      message = {}
      @sut = new job {@connector}
      @sut.do message, (@error, {@data, @metadata}) =>
        done()

    it 'should not error', ->
      expect(@error).not.to.exist

    it 'should call connector.getVolume', ->
      expect(@connector.getVolume).to.have.been.called

    it 'should return data', ->
      expect(@data.volume).to.equal 'Oops I did it again'
