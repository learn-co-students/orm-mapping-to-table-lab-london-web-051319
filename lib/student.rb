class Student
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  include Helper
  def initialize(*args, **hash)
    vars = %w(name grade id)
    super(vars, args, hash)
  end

  def self.create_table
    sql_input = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
        )
      SQL
    DB[:conn].execute(sql_input)
  end

  def self.drop_table
    sql_command = <<-SQL
      DROP TABLE
        students
      SQL
    DB[:conn].execute(sql_command)
  end

  def save
    sql_command = <<-SQL
      INSERT INTO
        students (
          name,
          grade
        ) VALUES (
          ?, ?
        )
      SQL
    DB[:conn].execute(sql_command, self.name, self.grade)
    @id = DB[:conn].execute(
      "SELECT LAST_INSERT_ROWID() FROM students"
    )[0][0]
    self
  end

  def self.create(**args)
    self.new(**args).save
  end
end
