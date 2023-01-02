require "http/client"
require "option_parser"
require "json"
require "html"

require "./ApiQuran/*"

destination = ""
surat = ""
ayat = ""
target = ""
waktu = {
  "imsak", "subuh",
  "terbit", "dhuha",
  "dzuhur", "ashar",
  "maghrib", "isya",
}

OptionParser.parse do |parser|
  parser.banner = "Usage: aswad [arguments]"
  parser.on("-t TARGET", "--target=TARGET", "target get Prayer Time or Interpretation") do |choose|
    target = choose
  end
  parser.on("-c NAME", "--city=NAME", "the name of the city you want to search for") do |name|
    destination = name
  end
  parser.on("-s SURAH", "--surah=SURAH", "surah") do |surah|
    surat = surah
  end
  parser.on("-a AYAH", "--ayah=AYAH", "ayah") do |ayah|
    ayat = ayah
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

if !target.empty?
  case target
  when "sholat"
    get = ApiQuran.new("sholat")
    jadwals = get.getScheduleNow destination
    puts "Jadwal Waktu Sholat untuk #{get.lokasi}\n"
    waktu.each do |x|
      puts x + "\t- " + jadwals[x].to_s
    end
    puts "Valid untuk #{jadwals["tanggal"]}\n"
  when "tafsir"
    get = ApiQuran.new("tafsir")
    get.getInterpretation(surat.to_u8, ayat.to_u8)
    puts "menampilkan tafsir \"#{surat}:#{ayat}\":\n\n"
    puts HTML.unescape(get.summary.to_s)
  else
    puts "Run 'aswad --help' for more information on a command."
    exit
  end
else
  puts "Run 'aswad --help' for more information on a command."
  exit
end
