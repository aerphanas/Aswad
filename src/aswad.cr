require "http/client"
require "option_parser"
require "json"

class ApiQuran
    property target
    getter idkota, jadwal

    def initialize(target : String, kota : String)
        @target = target
        @times = Time.local
        @tahun = @times.year
        @bulan = @times.month
        @tanggal = @times.day
        @url = "https://api.myquran.com/v1/"
        getIdCity kota 
    end
    def getIdCity(kota : String)
        url = "#{@url}#{@target}/kota/cari/#{kota}"
        request = HTTP::Client.get url
        @status = JSON.parse(request.body)["status"].to_s
        if @status == "true"
            @idkota = JSON.parse(request.body)["data"][0]["id"]
        elsif @status == "false"
            puts "error tidak ada kota dengan nama \"#{kota}\" dalam database"
            exit 1
        else
            puts "error"
            exit 1
        end
        
    end
    def getScheduleNow
        url = "#{@url}#{@target}/jadwal/#{@idkota}/#{@tahun}/#{@bulan}/#{@tanggal}"
        request = HTTP::Client.get url
        @jadwal = JSON.parse(request.body)["data"]["jadwal"]
    end
end

cek = ApiQuran.new "sholat", "jakarta"
waktu = {"imsak", "subuh", "terbit", "dhuha", "dzuhur", "ashar", "maghrib", "isya"}
jadwals = cek.getScheduleNow
puts "berikut adalah jadwal waktu solat untuk #{jadwals["tanggal"]}"
waktu.each do |x|
    puts  x + "\t- " + jadwals[x].to_s
end