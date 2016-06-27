Connector = require '../'

describe 'Connector', ->
  beforeEach (done) ->
    @sut = new Connector
    {@sonos} = @sut
    @sonos.connect = sinon.stub().yields null
    @sut.start {}, done

  afterEach (done) ->
    @sut.close done

  describe '->isOnline', ->
    it 'should yield running true', (done) ->
      @sut.isOnline (error, response) =>
        return done error if error?
        expect(response.running).to.be.true
        done()

  describe '->onConfig', ->
    beforeEach (done) ->
      options =
        ipAddress: '127.0.0.1'
      @sut.onConfig {options}, done

    it 'should call sonos.connect', ->
      expect(@sonos.connect).to.have.been.calledWith ipAddress: '127.0.0.1'

  describe '->getCurrentTrack', ->
    beforeEach (done) ->
      @sonos.getCurrentTrack = sinon.stub().yields null, currentTrack: 'Oops I did it again'
      @sut.getCurrentTrack (error, {@currentTrack}) =>
        done error

    it 'should call sonos.getCurrentTrack', ->
      expect(@sonos.getCurrentTrack).to.have.been.called

    it 'should yield currentTrack', ->
      expect(@currentTrack).to.equal 'Oops I did it again'

  describe '->getVolume', ->
    beforeEach (done) ->
      @sonos.getVolume = sinon.stub().yields null, volume: 0
      @sut.getVolume (error, {@volume}) =>
        done error

    it 'should call sonos.getVolume', ->
      expect(@sonos.getVolume).to.have.been.called

    it 'should yield volume', ->
      expect(@volume).to.equal 0

  describe '->getMuted', ->
    beforeEach (done) ->
      @sonos.getMuted = sinon.stub().yields null, muted: 0
      @sut.getMuted (error, {@muted}) =>
        done error

    it 'should call sonos.getMuted', ->
      expect(@sonos.getMuted).to.have.been.called

    it 'should yield muted', ->
      expect(@muted).to.equal 0

  describe '->mute', ->
    beforeEach (done) ->
      @sonos.mute = sinon.stub().yields null
      @sut.mute done

    it 'should call sonos.mute', ->
      expect(@sonos.mute).to.have.been.called

  describe '->unmute', ->
    beforeEach (done) ->
      @sonos.unmute = sinon.stub().yields null
      @sut.unmute done

    it 'should call sonos.unmute', ->
      expect(@sonos.unmute).to.have.been.called

  describe '->play', ->
    beforeEach (done) ->
      @sonos.play = sinon.stub().yields null
      @sut.play done

    it 'should call sonos.play', ->
      expect(@sonos.play).to.have.been.called

  describe '->playImmediately', ->
    beforeEach (done) ->
      @sonos.playImmediately = sinon.stub().yields null
      @sut.playImmediately uri: 'hi', done

    it 'should call sonos.playImmediately', ->
      expect(@sonos.playImmediately).to.have.been.calledWith uri: 'hi'

  describe '->playNext', ->
    beforeEach (done) ->
      @sonos.playNext = sinon.stub().yields null
      @sut.playNext uri: 'hi', done

    it 'should call sonos.playNext', ->
      expect(@sonos.playNext).to.have.been.calledWith uri: 'hi'

  describe '->setVolume', ->
    beforeEach (done) ->
      @sonos.setVolume = sinon.stub().yields null
      @sut.setVolume volume: 'hi', done

    it 'should call sonos.setVolume', ->
      expect(@sonos.setVolume).to.have.been.calledWith volume: 'hi'

  describe '->addToQueue', ->
    beforeEach (done) ->
      @sonos.addToQueue = sinon.stub().yields null
      @sut.addToQueue uri: 'hi', positionInQueue: 0, done

    it 'should call sonos.addToQueue', ->
      expect(@sonos.addToQueue).to.have.been.calledWith uri: 'hi', positionInQueue: 0

  describe '->pause', ->
    beforeEach (done) ->
      @sonos.pause = sinon.stub().yields null
      @sut.pause done

    it 'should call sonos.pause', ->
      expect(@sonos.pause).to.have.been.called

  describe '->previous', ->
    beforeEach (done) ->
      @sonos.previous = sinon.stub().yields null
      @sut.previous done

    it 'should call sonos.previous', ->
      expect(@sonos.previous).to.have.been.called

  describe '->next', ->
    beforeEach (done) ->
      @sonos.next = sinon.stub().yields null
      @sut.next done

    it 'should call sonos.next', ->
      expect(@sonos.next).to.have.been.called

  describe '->searchLibrary', ->
    beforeEach (done) ->
      options =
        searchType: 'searchy'
        searchTerm: 'termy'
        limit: 100
        offset: 0
      @sonos.searchLibrary = sinon.stub().yields null
      @sut.searchLibrary options, done

    it 'should call sonos.searchLibrary', ->
      options =
        searchType: 'searchy'
        searchTerm: 'termy'
        limit: 100
        offset: 0
      expect(@sonos.searchLibrary).to.have.been.calledWith options
