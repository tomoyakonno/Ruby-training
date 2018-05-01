class Csv
  # csvファイルとDateを扱うためのライブラリを使う
  require "csv"
  require "date"
  
  def main
    puts "読み込むファイル名 例:timesheet201804.csv"
    csvfile = gets.chomp
    
    time = {"Sun" => 0.0, "Mon" => 0.0, "Tue" => 0.0, "Wed" => 0.0, "Thu" => 0.0, "Fri" => 0.0, "Sat" => 0.0}
    day = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    csv_data = CSV.read(csvfile)
    
    csv_data.each_with_index do |data, n|
      time[day[Date.parse(data[0]).wday]] += data[3].to_f if n != 0
    end
    
    puts time
  end
end

cs = Csv.new
cs.main
