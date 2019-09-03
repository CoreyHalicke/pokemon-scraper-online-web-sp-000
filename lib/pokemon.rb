class Pokemon
  attr_accessor :id, :name, :type, :db


  def initialize(db)
    @id = id
    @name = name
    @type = type
    @db = db
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?, ?)
    SQL

    db.execute(sql, name, type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT *
      FROM pokemon
      WHERE id = ?
    SQL

    db.execute(sql, id).map do |row|
      new_pokemon = self.new(db)
      new_pokemon.id = row[0]
      new_pokemon.name = row[1]
      new_pokemon.type = row[2]
      new_pokemon
    end.first
  end

end
