class Calender
  # 年月入力メソッド
  def input
    p "年を入力 例:2018"
    @year = gets.to_i
    
    p "月を入力 例:4"
    @month = gets.to_i
    
    # @year,@month 実際に入力した年月
    # @year_z, @month_z ツェラーの公式用に変換した年月
    if @month == 1 || @month == 2
      @month_z = @month + 12
      @year_z = @year - 1
    else
      @month_z = @month
      @year_z = @year
    end
  end
  
  
  # ツェラーの公式を用い、入力した年月の1日の曜日を判定
  # @zeller == 0:日曜日 1:月曜日…
  def zeller
    @zeller = @year_z + (@year_z / 4) - (@year_z / 100) + (@year_z / 400) + (((@month_z * 13) + 8) / 5) + 1
    @zeller %= 7
  end
  
  
  # 入力した年がうるう年かを判定
  def leap
    if @year % 4 == 0
      if @year % 100 == 0 && @year % 400 != 0
        @leap = false
      else
        @leap = true
      end
    else
      @leap = false
    end
    
    # puts "うるう年:#{@leap}"
  end
  
  
  # カレンダー出力
  def put
    puts "#{@month}月 #{@year}年"
    puts "Sun Mon Tue Wed Thu Fri Sat"
    
    # @zellerの数*4マス空白
    @zeller.times do
      print "    "
    end
    
    #loop用の日付変数date
    date = 1
    
    # loopで1から順に数字を出力
    loop do
      # 日付が土曜であれば改行したいので、変数zellerを用意
      zeller = @year_z + (@year_z / 4) - (@year_z / 100) + (@year_z / 400) + (((@month_z * 13) + 8) / 5) + date
      zeller %= 7
      
      # 土曜になったら書き込みと改行、土曜以外は書き込みのみ
      if zeller == 6
        print format("%3d\n", date)
      else
        print format("%3d", date) + " "
      end
      
      # 月の最終日まで来たら、改行出力後にloopをbreak
      if @month == 2
        # 2月のみうるう年判定
        if @leap
          if date == 29
            puts
            break
          end
        else
          if date == 28
            puts
            break
          end
        end
      elsif @month == 4 || @month == 6 || @month == 9 || @month == 11
        if date == 30
          puts
          break
        end
      else
        if date == 31
          puts
          break
        end
      end
      
      # 日付を1進める
      date += 1
    end
  end
end


cl = Calender.new
cl.input
cl.zeller
cl.leap
cl.put
