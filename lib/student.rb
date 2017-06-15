class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id


  def initialize(name, grade, *id)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTEGER
    );
    SQL
    DB[:conn].execute(sql)
    # binding.pry

  end

  def self.drop_table
    sql = <<-SQL
    DROP TABLE IF EXISTS students;
    SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-Table
    INSERT INTO students (name, grade) VALUES (?, ?)
    Table
    #need to get last ID number

    DB[:conn].execute(sql, self.name, self.grade)
    id_find = "Select id from students order by id DESC limit 1"

    # binding.pry

    new_id = DB[:conn].execute(id_find).first
    @id = new_id.flatten[0]

  end

  def self.create(name:, grade:)
    student = self.new(name, grade)
    student.save
    student

  end

end
