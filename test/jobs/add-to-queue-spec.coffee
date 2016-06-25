{job} = require '../../jobs/add-to-queue'

describe 'AddToQueue', ->
  context 'when given a valid message', ->
    beforeEach (done) ->
      @connector =
        addToQueue: sinon.stub().yields null
      message =
        data:
          uri: 'hi'
          positionInQueue: 0
      @sut = new job {@connector}
      @sut.do message, (@error) =>
        done()

    it 'should not error', ->
      expect(@error).not.to.exist

    it 'should call connector.addToQueue', ->
      expect(@connector.addToQueue).to.have.been.calledWith uri: 'hi', positionInQueue: 0

  context 'when given an invalid message', ->
    beforeEach (done) ->
      @connector = {}
      message = {}
      @sut = new job {@connector}
      @sut.do message, (@error) =>
        done()

    it 'should error', ->
      expect(@error).to.exist
