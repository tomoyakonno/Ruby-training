class Calender
  MONTH_30 = [4, 6, 9, 11]
  MONTH_31 = [1, 3, 5, 7, 8, 10, 12]
  
  # 年月入力メソッド
  def initialize
    p "年を入力 例:2018"
    @year = gets.to_i
    
    p "月を入力 例:4"
    @month = gets.to_i
    
    # 実際に入力した年月 @year, @month
    # ツェラーの公式用に変換した年月 @year_z, @month_z
    if @month == 1 || @month == 2
      @month_z = @month + 12
      @year_z = @year - 1
    else
      @month_z = @month
      @year_z = @year
    end
  end
  
  
    # 入力した年がうるう年かを判定
  def leap?
    @year % 400 == 0 || @year % 4 == 0 && @year % 100 != 0
  end
  
  
  # カレンダー出力
  def main
    puts "----------------------------"
    puts "#{@year}年 #{@month}月".center(27)
    puts "Sun Mon Tue Wed Thu Fri Sat"
    
    # ツェラーの公式を用い、入力した年月の1日の曜日を判定
    # zeller_1 == 0:日曜日 1:月曜日…
    zeller = @year_z + (@year_z / 4) - (@year_z / 100) + (@year_z / 400) + (((@month_z * 13) + 8) / 5)
    zeller_1 = (zeller + 1) % 7
    
    # zeller_1の数*4マス空白
    print "    " * zeller_1
    
    # 各月の最終日を決める
    # 入力した@monthが定数配列MONTH_30, MONTH_31に含まれているかで判定
    date_end = 28 if @month == 2 && !leap?
    date_end = 29 if @month == 2 && leap?
    date_end = 30 if MONTH_30.include?(@month)
    date_end = 31 if MONTH_31.include?(@month)
    
    date_end.times do |date|
      # 日付と空白を出力
      print format("%3d", date + 1) + " "
      
      # 日付の曜日を判定する変数zeller_dateを用意
      # 土曜になったら改行
      zeller_date = (zeller + date + 1) % 7
      puts if zeller_date == 6 && date + 1 != date_end
    end
    
    # 改行
    puts
    puts "----------------------------"
  end
end


cl = Calender.new
cl.main
