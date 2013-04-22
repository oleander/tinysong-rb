# Tinysong

Scrapes tinysong.com, which means that there aren't any request limitations.

## Installation

    $ [sudo] gem install tinysong

## Usage

``` ruby
songs = Tinysong::Search.all("smoke on the water deep purple")
songs.each do |song|
  song.artist # => "Deep Purple"
  song.title  # => "Smoke on the Water"
  song.href   # => "http://tinysong.com/RjVu"
  song.id     # => 33682674
end
```

``` ruby
song = Tinysong::Search.find("smoke on the water deep purple")
```

**Note:** `Tinysong::Search` does N + 1 requests, so if you only need one result use `Tinysong::Search.find`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
