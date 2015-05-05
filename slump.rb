require_relative 'student'

def student_list_maker

  # Public:
  #
  # How it works/Example:
  # elev_list_maker
  # students.txt = Daniel_Berg 9
  #                Bosse_Python 8
  #
  # => list_of_all_students = [Daniel, Bosse]
  #
  #  Daniel = #<Student:0x007fe2ca020968> => name: Daneil_Berg, grade: 9, opt_grade_min: 6, opt_grade_max: 12
  #  Bosse = #<Student:0x007fe2ca020233> => name: Bosse_Python, grade: 8, opt_grade_min: 5, opt_grade_max: 11
  #
  # Makes a list of students as object from class Student




  list_of_all_students = []

  file = File.open('students.txt', 'r')
  file.each_line do |line|
    values_of_row = line.split(' ')
    student = Student.new(values_of_row.first, values_of_row.last)
    list_of_all_students<<student
  end
  return list_of_all_students

end

def presence(list_of_all_students)

  # Public:
  #
  # Values:
  #
  # counter - keeps check that it dosent look at a position outside the list as the list gets smaller
  #
  # How it works/Example:
  #
  # list_of_all_students = [Daniel, Bosse]
  # presence(list_of_all_students)
  # "Daniel_Berg"
  # <presses only enter>
  # "Närvarande"
  #
  # "Bosse_Python"
  # <presses something more and then enter>
  # "Frånvarande"
  # # => [Daniel]
  #
  #  Daniel = #<Student:0x007fe2ca020968> => name: Daneil_Berg, grade: 9, opt_grade_min: 6, opt_grade_max: 12
  #  Bosse = #<Student:0x007fe2ca020233> => name: Bosse_Python, grade: 8, opt_grade_min: 5, opt_grade_max: 11
  #
  # in this example Bosse is not presence and he is removed from the return array
  #


  list_of_all_students_presence = []
   position_in_list = 0
  counter = 0
  while counter < list_of_all_students.length
    counter += 1
    student_at_current_position = list_of_all_students[0 + position_in_list]
    puts ""
    puts student_at_current_position.name
    key_press = gets.chomp
    if key_press == ""
      puts "Närvarande"
      position_in_list += 1
      list_of_all_students_presence<<(student_at_current_position)
    else
      puts "Frånvarande"
    end
  end
  return list_of_all_students_presence
end

def not_presence(list_of_all_students_missing, list_of_all_students_presence)

  # Public:
  #
  # How it works/Example:
  #
  # list_of_all_students = [Daniel, Bosse]
  # list_of_all_students_presence = [Daniel]
  #
  # not_presence(list_of_all_students, list_of_all_students_presence)
  #
  # # => list_of_all_students_missing = [Bosse]
  #
  # takes the list of all students and the list of students presence and starts removing the presence from the list and making it to a list of all students missing

  list_of_all_students_presence = list_of_all_students_presence
  list_of_all_students_missing = list_of_all_students_missing
  while list_of_all_students_presence > 0
    list_of_all_students_missing.delete(list_of_all_students_presence[0])
    list_of_all_students_presence.delete(0)

  end
  list_of_all_students_missing
  return list_of_all_students_missing

end


def main

  list_of_all_students = student_list_maker
  list_of_all_students_presence = presence(list_of_all_students)
  list_of_all_students_missing = not_presence(list_of_all_students, list_of_all_students_presence)




  while list_of_all_students_presence.count >= 2
    good_pair = false
    pair1 = list_of_all_students_presence.sample
    list_of_all_students_presence.delete(pair1)
    partner_list = list_of_all_students_presence.dup
    desperate_level = 0
    begin
      file = File.open("#{pair1.name}.txt", "r")
      dont_match = file.readline
    rescue IOError => e
      #some error occur, dir not writable etc.
    ensure
      file.close unless file == nil
    end
    until good_pair == true
      pair2 = partner_list.sample
      if desperate_level == 0


      if pair2.grade.to_i == pair1.opt_grade_max.to_i - desperate_level
      good_pair = true

      elsif pair2.grade.to_i == pair1.opt_grade_min.to_i + desperate_level
        good_pair = true
      end

      elsif desperate_level >= 4
        good_pair = true
        puts "No optimised partner found"


      end
      if pair2.name == dont_match
        good_pair = false
        if desperate_level >= 4
          good_pair = true
        end
      end

      if good_pair == false
        partner_list.delete(pair2)
        if partner_list.count == 0
          partner_list = list_of_all_students_presence.dup
          desperate_level += 1
        end
      end

    end

    begin
      file = File.open("#{pair1.name}.txt", "r+")
      file.write("#{pair2.name}")
    rescue IOError => e
      #some error occur, dir not writable etc.
    ensure
      file.close unless file == nil
    end

    begin
      file = File.open("#{pair2.name}.txt", "r+")
      file.write("#{pair1.name}")
    rescue IOError => e
      #some error occur, dir not writable etc.
    ensure
      file.close unless file == nil
    end


    list_of_all_students_presence.delete(pair2)
    "#{pair1.name} + #{pair2.name} ".each_char {|c| putc c ; sleep 0.07; $stdout.flush }
    puts ""
    puts "Desperate_level = #{desperate_level}"
    puts ""
  end
  if list_of_all_students_presence.count == 1
    pair1 = list_of_all_students_presence.sample
    "#{pair1.name}".each_char {|c| putc c ; sleep 0.07; $stdout.flush }
  end
  puts ""
  puts ""
  puts "Frånvarande:"
  numberF = 0
  until list_of_all_students_missing.count == numberF
    puts list_of_all_students_missing[0 + numberF].name
    numberF += 1
    sleep 0.5
  end
  puts ""
  puts ""
  puts "Thanks for using Slumpinator 3.5 Optimise Edition"
  end

elev_list_maker