require "http/client"
require "option_parser"
require "json"

class ApiQuran
  property target
  getter idkota, jadwal, lokasi

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
      @lokasi = JSON.parse(request.body)["data"][0]["lokasi"]
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

destination = ""
waktu = {"imsak", "subuh", "terbit", "dhuha", "dzuhur", "ashar", "maghrib", "isya"}

OptionParser.parse do |parser|
  parser.banner = "Usage: aswad [arguments]"
  parser.on("-c NAME", "--city=NAME", "Specifies the name to salute") do |name|
    destination = name
  end
  parser.on("-h", "--help", "Show this help") do
    puts parser
    exit
  end
  parser.invalid_option do |flag|
    STDERR.puts "ERROR: #{flag} is not a valid option."
    STDERR.puts parser
    exit(1)
  end
  parser.missing_option do |flag|
    STDERR.puts "ERROR: #{flag} is missing some option."
    STDERR.puts parser
    exit(1)
  end
end


if !destination.empty?
  get = ApiQuran.new("sholat", destination)
  jadwals = get.getScheduleNow
  puts "Jadwal Waktu Sholat untuk #{get.lokasi}\n"
  waktu.each do |x|
    puts  x + "\t- " + jadwals[x].to_s
  end
  puts "Valid untuk #{jadwals["tanggal"]}\n"
else
  puts "Run 'aswad --help' for more information on a command."
  exit 
end
