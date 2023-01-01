# aswad

[![Crystal CI](https://github.com/aerphanas/Aswad/actions/workflows/crystal.yml/badge.svg)](https://github.com/aerphanas/Aswad/actions/workflows/crystal.yml)

get current Prayer Time and more comming soon   

## Prerequisites

- crystal v1.2.2
- zlib (libz)
- openssl (libssl, libcrypto)

## Installation

```sh
git clone https://github.com/aerphanas/Aswad.git
cd Aswad
crystal build --release ./src/aswad.cr -o ./bin/aswad
```

## Usage

```sh
./bin/aswad -c <city name> # Get Current Prayer Times 
./bin/aswad -h # More Information on a Command.
```

## Contributing

1. Fork it (<https://github.com/aerphanas/aswad/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Thanks so

- [api.myquran.com](https://api.myquran.com/) for Prayer time api

## Contributors

- [Muhammad Aviv Burhanudin](https://github.com/aerphanas) - creator and maintainer
