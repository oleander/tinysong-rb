describe Tinysong::Search do
  use_vcr_cassette

  describe "find" do
    it "returns on song" do
      song = Tinysong::Search.find("smoke on the water deep purple")
      song.title.should eq("Smoke on the Water")
      song.artist.should eq("Deep Purple")
      song.id.should be_a(Fixnum)
      song.id.should > 0
      song.href.should match(%r{http://tinysong.com/\w+})
    end

    it "doesn't raise error if nothing is found" do
      lambda {
        Tinysong::Search.find("667a4af374347aaebc6d04d8572fbb85")
      }.should_not raise_error
    end
  end

  describe "all" do
    it "returns a list of songs" do
      songs = Tinysong::Search.all("smoke on the water deep purple")
      songs.first.should be_a(Tinysong::Song)
    end

    it "limits the result" do
      songs = Tinysong::Search.all("smoke on the water deep purple", limit: 0)
      songs.length.should eq(0)

      songs = Tinysong::Search.all("smoke on the water deep purple", limit: 1)
      songs.length.should eq(1)
    end

    it "defaults to 5 results" do
      songs = Tinysong::Search.all("smoke on the water deep purple")
      songs.length.should eq(5)
    end

    it "doesn't raise error if nothing is found" do
      lambda {
        Tinysong::Search.all("667a4af374347aaebc6d04d8572fbb85")
      }.should_not raise_error
    end
  end
end