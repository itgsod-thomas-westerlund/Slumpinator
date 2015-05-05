class Student

  attr_reader :name, :grade, :opt_grade_min, :opt_grade_max

  def initialize(name, grade)
    @name = name
    @grade = grade
    @opt_grade_min = grade.to_i - 3
    @opt_grade_max = grade.to_i + 3
  end

end