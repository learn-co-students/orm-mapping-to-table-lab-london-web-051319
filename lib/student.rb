class Student

  attr_accessor :name, :grade
#the name attribute can be accessed
#the grade attribute can be accessed

  attr_reader :id
  #responds to a getter for :id ^^

  @@all = []


  def initialize(name, grade, id=nil)
  #does not provide a setter for :id = (id=nil)
    @id = id
    @name = name
    @grade = grade
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_table
    sql =  <<-SQL
      CREATE TABLE students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
        );
        SQL
        DB[:conn].execute(sql)
      end
#creates the students table in the database

      def self.drop_table
        sql = "DROP TABLE students;"
        DB[:conn].execute(sql)
      end

      def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.grade)

    @id = DB[:conn].execute("SELECT last_insert_rowid()
    FROM students")[0][0]
  end
  #saves an instance of the Student class to the database

  def self.create(name:, grade:)
student = Student.new(name, grade)
student.save
student
end
#takes in a hash of attributes and uses metaprogramming to create a new student object.
#save method to save that student to the database
#returns the new object that it instantiated

end
