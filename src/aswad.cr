require "http/client"
require "option_parser"
require "json"

kota = "jakarta"

urlSholat = "https://api.myquran.com/v1/sholat/"
urlidkota = "#{urlSholat}kota/cari/#{kota}"

request = HTTP::Client.get urlidkota

times = Time.local
tahun = times.year
bulan = times.month
tanggal = times.day

idkota = JSON.parse(request.body)["data"][0]["id"].to_s

url = "#{urlSholat}jadwal/#{idkota}/#{tahun}/#{bulan}/#{tanggal}"
#p! request.body
#p! JSON.parse(request.body)["data"][0]["id"].to_s
p! JSON.parse(HTTP::Client.get(url).body)["data"]["jadwal"].to_pretty_json