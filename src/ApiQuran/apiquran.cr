class ApiQuran
  property target
  getter idkota, idtafsir, jadwal, lokasi, summary, full

  def initialize(target : String)
    @ayahs = {
      0, 7, 286, 200, 176, 120, 165, 206,
      75, 129, 109, 123, 111, 43, 52, 99,
      128, 111, 110, 98, 135, 112, 78, 118,
      64, 77, 227, 93, 88, 69, 60, 34,
      30, 73, 54, 45, 83, 182, 88, 75,
      85, 54, 53, 89, 59, 37, 35, 38,
      29, 18, 45, 60, 49, 62, 55, 78,
      96, 29, 22, 24, 13, 14, 11, 11,
      18, 12, 12, 30, 52, 52, 44, 28,
      28, 20, 56, 40, 31, 50, 40, 46,
      42, 29, 19, 36, 25, 22, 17, 19,
      26, 30, 20, 15, 21, 11, 8, 8,
      19, 5, 8, 8, 11, 11, 8, 3,
      9, 5, 4, 7, 3, 6, 3, 5,
      4, 5, 6,
    }
    @target = target
    @times = Time.local
    @url = "https://api.myquran.com/v1/"
  end

  def getIdCity(kota : String)
    url = "#{@url}#{@target}/kota/cari/#{kota}"
    request = HTTP::Client.get url
    @status = JSON.parse(request.body)["status"].to_s
    if @status == "true"
      @idkota = JSON.parse(request.body)["data"][0]["id"]
      @lokasi = JSON.parse(request.body)["data"][0]["lokasi"]
    elsif @status == "false"
      puts "error tidak ada kota dengan nama \"#{kota}\" dalam database"
      exit 1
    else
      puts "error"
      exit 1
    end
  end

  def getScheduleNow(kota : String)
    @tahun = @times.year
    @bulan = @times.month
    @tanggal = @times.day
    getIdCity kota
    url = "#{@url}#{@target}/jadwal/#{@idkota}/#{@tahun}/#{@bulan}/#{@tanggal}"
    request = HTTP::Client.get url
    @jadwal = JSON.parse(request.body)["data"]["jadwal"]
  end

  def getInterpretation(surah : UInt8, ayat : UInt8)
    idtafsir = @ayahs[(surah - 1)] + ayat
    url = "#{@url}#{@target}/quran/kemenag/id/#{idtafsir}"
    request = HTTP::Client.get url
    @status = JSON.parse(request.body)["status"].to_s
    if @status == "true"
      @summary = JSON.parse(request.body)["data"][0]["text"].to_s
      @full = JSON.parse(request.body)["data"][1]["text"].to_s
    elsif @status == "false"
      puts "error tidak ada surah #{surah.to_s} dan ayat #{ayat.to_s} dalam database"
    else
      puts "error"
      exit 1
    end
  end
end
