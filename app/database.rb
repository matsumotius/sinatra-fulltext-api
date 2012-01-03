require "estraier"
include Estraier

class DB
  def initialize
    @mode = {
      "reader" => Database::DBREADER,
      "writer" => Database::DBWRITER | Database::DBCREAT
    }
    @option = {
      :db  => "jkfd.memo",
      :uri => "/home/myatsumoto/ruby/jkfd/api/db/"
    }
    @db = Database::new
  end

  def open(mode)
    unless @db.open(@option[:uri] + @option[:db], @mode[mode])
      puts "error: #{@db.err_msg(@db.error)}"
    end
  end

  def put(doc)
    unless @db.put_doc(doc, Database::PDCLEAN)
      puts "error: #{@db.err_msg(@db.error)}"
    end
  end

  def out(id)
    unless @db.out_doc(id, Database::ODCLEAN)
      puts "error: #{@db.err_msg(@db.error)}"
    end
  end

  def close
    unless @db.close
      puts "error: #{@db.err_msg(@db.error)}"
    end
  end

  def drop
    FileUtils.remove_entry_secure(@option[:uri] + @option[:db], false)
    puts "database droped"
  end
end

