SonosManager = require '../src/sonos-manager'

describe 'SonosManager', ->
  beforeEach ->
    @sut = new SonosManager
    {@Sonos} = @sut
    @sonos =
      destroy: sinon.stub().yields null
    @Sonos.search = sinon.stub().yields @sonos

  beforeEach (done) ->
    @sut.connect {}, done

  afterEach (done) ->
    @sut.close done

  it 'should exist', ->
    expect(@sut).to.exist

  it 'should try to connect to a sonos', ->
    expect(@Sonos.search).to.have.been.called

  describe '->getCurrentTrack', ->
    beforeEach (done) ->
      @sonos.currentTrack = sinon.stub().yields null, 'Oops I did it again'
      @sut.getCurrentTrack (error, {@currentTrack}) =>
        done error

    it 'should call sonos.getCurrentTrack', ->
      expect(@sonos.currentTrack).to.have.been.called

    it 'should yield currentTrack', ->
      expect(@currentTrack).to.equal 'Oops I did it again'

  describe '->searchLibrary', ->
    beforeEach (done) ->
      options =
        searchType: 'artists'
        searchTerm: 'Spears'
        limit: 100
        offset: 0
      @sonos.searchMusicLibrary = sinon.stub().yields null, []
      @sut.searchLibrary options, (error, @results) =>
        done error

    it 'should call sonos.searchMusicLibrary', ->
      expect(@sonos.searchMusicLibrary).to.have.been.calledWith 'artists', 'Spears', {start: 0, total: 100}

    it 'should yield searchLibrary', ->
      expect(@results).to.deep.equal []

  describe '->getVolume', ->
    beforeEach (done) ->
      @sonos.getVolume = sinon.stub().yields null, 0
      @sut.getVolume (error, {@volume}) =>
        done error

    it 'should call sonos.getVolume', ->
      expect(@sonos.getVolume).to.have.been.called

    it 'should yield volume', ->
      expect(@volume).to.equal 0

  describe '->getMuted', ->
    beforeEach (done) ->
      @sonos.getMuted = sinon.stub().yields null, 0
      @sut.getMuted (error, {@muted}) =>
        done error

    it 'should call sonos.getMuted', ->
      expect(@sonos.getMuted).to.have.been.called

    it 'should yield muted', ->
      expect(@muted).to.equal 0

  describe '->mute', ->
    beforeEach (done) ->
      @sonos.setMuted = sinon.stub().yields null
      @sut.mute done

    it 'should call sonos.setMuted', ->
      expect(@sonos.setMuted).to.have.been.calledWith true

  describe '->unmute', ->
    beforeEach (done) ->
      @sonos.setMuted = sinon.stub().yields null
      @sut.unmute done

    it 'should call sonos.setMuted', ->
      expect(@sonos.setMuted).to.have.been.calledWith false

  describe '->play', ->
    beforeEach (done) ->
      @sonos.play = sinon.stub().yields null
      @sut.play done

    it 'should call sonos.play', ->
      expect(@sonos.play).to.have.been.called

  describe '->pause', ->
    beforeEach (done) ->
      @sonos.pause = sinon.stub().yields null
      @sut.pause done

    it 'should call sonos.pause', ->
      expect(@sonos.pause).to.have.been.called

  describe '->playImmediately', ->
    beforeEach (done) ->
      @sonos.play = sinon.stub().yields null
      @sut.playImmediately uri: 'hi', done

    it 'should call sonos.play', ->
      expect(@sonos.play).to.have.been.calledWith 'hi'

  describe '->playNext', ->
    beforeEach (done) ->
      @sonos.queueNext = sinon.stub().yields null
      @sut.playNext uri: 'hi', done

    it 'should call sonos.queueNext', ->
      expect(@sonos.queueNext).to.have.been.calledWith 'hi'

  describe '->addToQueue', ->
    beforeEach (done) ->
      @sonos.queue = sinon.stub().yields null
      @sut.addToQueue uri: 'hi', positionInQueue: 0, done

    it 'should call sonos.queue', ->
      expect(@sonos.queue).to.have.been.calledWith 'hi', 0

  describe '->setVolume', ->
    beforeEach (done) ->
      @sonos.setVolume = sinon.stub().yields null
      @sut.setVolume volume: 'hi', done

    it 'should call sonos.setVolume', ->
      expect(@sonos.setVolume).to.have.been.calledWith 'hi'
