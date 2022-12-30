require "http/client"
require "option_parser"

module Aswad
  VERSION = "0.1.0"

  tahun = "2022"
  bulan = "12"
  tanggal = "30"
  idkota = "1609"
  
  request = "https://api.myquran.com/v1/sholat/jadwal/#{idkota}/#{tahun}/#{bulan}/#{tanggal}"
  p! request
  puts "hello world"
end
