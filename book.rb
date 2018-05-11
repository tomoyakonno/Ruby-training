require "sqlite3"

class Book
  
  # データベースbook.db内にテーブルbookを作成し、要素を追加するメソッド
  def create_table
    return if File.exist?("book.db") # データベースbook.dbが既に存在していたら、何もしない
    
    # book内に入れるデータ
    data1 = ["楽しいRuby", 2600]
    data2 = ["優しいRuby", 13000]
    data3 = ["楽しいC", 50000]
    data4 = ["優しいC", 1000]
    
    SQLite3::Database.open("book.db") do |db|
      db.execute("CREATE TABLE book (name TEXT, price INTEGER)") # テーブルbookを作成
      db.execute("INSERT INTO book VALUES (?, ?),(?, ?),(?, ?),(?, ?)", data1, data2, data3, data4) # 上で定義したdata1~data4をbookに入れる
    end
  end
  
  
  # bookの全データを表示するメソッド
  def view_table
    ret = [] # 抽出したデータを格納する配列ret
    
    SQLite3::Database.open("book.db") do |db|
      db.execute("SELECT * FROM book") do |row| # "SELECT * FROM book"の条件でデータを抽出
        ret << row.join(" | ") # 抽出した配列を" | "で区切りながら結合し、配列retに格納
      end
    end
    
    return ret # retを戻り値として返す
  end
  
  
  # bookの内、price >= 10000のデータを表示するメソッド
  # view_tableの条件部分を変えただけ
  def select_data_price
    ret = []
    
    SQLite3::Database.open("book.db") do |db|
      db.execute("SELECT * FROM book WHERE price >= 10000") do |row|
        ret << row.join(" | ")
      end
    end
    
    return ret
  end
  
  
  # bookの内、nameに"楽しい"が含まれるデータを表示するメソッド
  # view_tableの条件部分を変えただけ
  def select_data_name
    ret = []
    
    SQLite3::Database.open("book.db") do |db|
      db.execute("SELECT * FROM book WHERE name LIKE '%楽しい%'") do |row| ret << row.join(" | ") end
    end
    
    return ret
  end
  
  
  # nameを昇順にして並び替えるメソッド
  # view_tableの条件部分を変えただけ
  def order_name
    ret = []
    
    SQLite3::Database.open("book.db") do |db|
      db.execute("SELECT * FROM book ORDER BY name ASC") do |row|
        ret << row.join(" | ")
      end
    end
    
    return ret
  end
  
  
  # priceを降順にして並び替えるメソッド
  # view_tableの条件部分を変えただけ
  def order_price
    ret = []
    
    SQLite3::Database.open("book.db") do |db|
      db.execute("SELECT * FROM book ORDER BY price DESC") do |row|
        ret << row.join(" | ")
      end
    end
    
    return ret
  end
  
  
  # nameが"楽しいRuby"の場合にpriceを2500に書き換えるメソッド
  def update_data
    SQLite3::Database.open("book.db") do |db|
      db.execute("UPDATE book SET price = 2500 WHERE name = '楽しいRuby'")
    end
    
    # 変更を確認するためにview_tableを出力
    puts view_table
  end
end


# irb上で下記を動かす

# require "./book.rb"
# bo = Book.new
# bo.create_table
# puts bo.view_table
# puts bo.select_data_name
# puts bo.select_data_price
# puts bo.order_name
# puts bo.order_price
# bo.update_data
