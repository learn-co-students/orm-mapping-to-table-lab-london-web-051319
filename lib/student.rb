class Student

attr_accessor :name, :grade
attr_reader :id

def initialize(name, grade, id=nil)
  @name = name
  @grade = grade
  @id = id
end

def self.create_table
  sql = <<-SQL
  CREATE TABLE IF NOT EXISTS students(
    id INTEGER PRIMARY KEY,
    name TEXT,
    grade TEXT
  )
  SQL
  DB[:conn].execute(sql)
end

def self.drop_table
  sql = <<-SQL
    DROP TABLE students
  SQL
  DB[:conn].execute(sql)
end

def save
  DB[:conn].execute('INSERT INTO students(name, grade) VALUES(?,?)', self.name, self.grade)
  @id = DB[:conn].execute('select last_insert_rowid() from students')[0][0]
end

def self.create(name:, grade:)
  student = Student.new(name, grade)
  student.save
  student
end



end
