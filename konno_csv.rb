class Csv
  # csvファイルとDateを扱うためのライブラリを使う
  require "csv"
  require "date"
  
  # 曜日を定数として定義
  DAY = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
  
  
  def main
    puts "読み込むファイル名 例:timesheet201804.csv"
    
    # csvファイル名を入力させる
    csvfile = gets.chomp
    
    # 曜日ごとの合計時間を入れるための変数配列time
    time = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    
    # 入力したcsvファイルを、一行目をヘッダーとして読み込み
    csv_data = CSV.read(csvfile, headers: true)
    
    # "勤務日"から曜日を読み取り、time内の曜日に応じた場所に"作業時間"を足す
    csv_data.each do |data|
      time[Date.parse(data["勤務日"]).wday] += data["作業時間"].to_f
    end
    
    # 何日から何日までかを出力
    puts "#{csv_data["勤務日"].last} ~ #{csv_data["勤務日"].first}"
    
    # 曜日を定数配列DAYから、時間を変数配列timeから出力
    time.each_with_index do |m, n|
      print DAY[n] + " "
      puts m
    end
  end
end

cs = Csv.new
cs.main
