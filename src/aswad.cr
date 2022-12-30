require "http/client"
require "option_parser"
require "json"

module Aswad
  VERSION = "0.1.0"

  tahun = "2022"
  bulan = "12"
  tanggal = "30"
  idkota = "1609"
  
  url = "https://api.myquran.com/v1/sholat/jadwal/#{idkota}/#{tahun}/#{bulan}/#{tanggal}"
  request = HTTP::Client.get url
  #p! request.body
  puts JSON.parse(request.body).to_pretty_json
end
