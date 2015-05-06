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
  # counter - counts trough the list_of_all_students
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
  # it duplicates the list_of_all_students and make it in to list_of_all_students_presence
  # every students that not present gets removed from the list_of_all_students_presence
  # doess until it went trough all the names in list_of_students
  #


  list_of_all_students_presence = list_of_all_students.dup
  counter = 0
  while counter < list_of_all_students.length
    student_at_current_position = list_of_all_students[0 + counter]
    puts ""
    puts student_at_current_position.name
    key_press = gets.chomp
    if key_press == ""
      puts "Närvarande"
    else
      puts "Frånvarande"
      list_of_all_students_presence.delete(student_at_current_position)

    end
    counter += 1
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
  while list_of_all_students_presence.count > 0
    delete_this = list_of_all_students_presence[0]
    list_of_all_students_presence.delete(delete_this)
    list_of_all_students_missing.delete(delete_this)
    list_of_all_students_presence.delete(0)

  end
  list_of_all_students_missing
  return list_of_all_students_missing

end

def pair_maker(list_of_all_students_presence_fixed)

  # Public:
  #
  # Values:
  # good_pair - decides if true, the pair is final and should be printed out. or if false, try another partner
  # desperate_level - decides how far away the pair maker should go from the most optimised partner grade
  # .opt_grade_max/min - the most optimised grade for this student
  # .grade - the grade of a student
  #
  #
  #
  # How it works/Example:
  #
  # list_of_all_students_presence = [Student1, Student2, Student3, Student4]
  # Student1.grade = 5, Student2.grade = 3, Student3.grade = 8. Student4.grade = 6
  # <the .opt_garde_max/min is -+ 3 from the students original grade>
  #
  # pair_maker(list_of_all_students_presence)
  #
  # "Student1 + Student3"
  # "Desperate_level = 0"
  #
  # "Student2 + Student4"
  # "Desperate_level = 0"
  #
  # end
  #
  # makes a dup of list_of_students_presence_fixed to fix a bug
  # first it sets good_pair to false
  # it takes a random Student from the list_of_all_students_presence, that student is now pair_partner_1 and is removed from the list
  # it then makes a duplicate of the list_of_all_students_presence and make it in to list_of_partners, this list doess not have pair_partner_1 in it
  # it then reads the txt file of the pair_partner_1.name and saves what it reads from there in dont_match_with, this is the name that this partner was previously matched with
  # it then starts taking samples from the list_of_partners and making them in to pair_partner_2 and looking if the .grade of pair_partner2 is = to the .opt_grade_min/max of the pair_partner_1
  # if it finds a pair_partner_2 that has .grade = .opt_grade_min/max of pair partner_1 it opens both file and writes in each others .name (pair_partner_1.txt will have pair_partner_2.name in it and the other way around) and sets good_pair = true
  # it then writes out the pair "pair_partner_1 + pair_partner_2" and the desperate_level
  # if the sample from list_of_partner dosent have .grade thats = to .opt_grade_min/max of pair_partner_1 it deletes that sample from the list and takes a new sample
  # if the list_of_pair_partner gets empty, it will increse the desperate_level to += 1 and this makes the .opt_grade_max/min go down by 1 so it will look for partner with a .grade closer to the grade of pair_partner_1
  # repetes until sucsess or reaching desperate_level = 4 which then just picks a random partner from the list_of_partners and forces good_pair = true and writes out No optimised partner found"
  # if theres only 1 left in list_of_all_students_presence it will not look for a partner and just write out the .name
  #
puts "started"

list_of_all_students_presence = list_of_all_students_presence_fixed.dup

  while list_of_all_students_presence.count >= 2
    good_pair = false
    pair_partner_1 = list_of_all_students_presence.sample
    list_of_all_students_presence.delete(pair_partner_1)
    puts pair_partner_1.name
    list_of_partners = list_of_all_students_presence.dup
    desperate_level = 0

    begin
      file = File.open("#{pair_partner_1.name}.txt", "r")
      dont_match_with = file.readline
    rescue IOError => e
      #some error occur, dir not writable etc.
    ensure
      file.close unless file == nil
    end

    until good_pair == true
      pair_partner_2 = list_of_partners.sample

        if pair_partner_2.grade.to_i == pair_partner_1.opt_grade_max.to_i - desperate_level
          good_pair = true

        elsif pair_partner_2.grade.to_i == pair_partner_1.opt_grade_min.to_i + desperate_level
          good_pair = true
        end

      if desperate_level >= 4
        good_pair = true
        puts "No optimised partner found"
      end
      if pair_partner_2.name == dont_match_with
        good_pair = false
        if desperate_level >= 4
          good_pair = true
        end
      end

      if good_pair == false
        list_of_partners.delete(pair_partner_2)
        if list_of_partners.count == 0
          list_of_partners = list_of_all_students_presence.dup
          desperate_level += 1
        end
      end

    end

    begin
      file = File.open("#{pair_partner_1.name}.txt", "w")
      file.write("#{pair_partner_2.name}")
    rescue IOError => e
      #some error occur, dir not writable etc.
    ensure
      file.close unless file == nil
    end

    begin
      file = File.open("#{pair_partner_2.name}.txt", "w")
      file.write("#{pair_partner_1.name}")
    rescue IOError => e
      #some error occur, dir not writable etc.
    ensure
      file.close unless file == nil
    end


    list_of_all_students_presence.delete(pair_partner_2)
    "#{pair_partner_1.name} + #{pair_partner_2.name}".each_char {|c| putc c ; sleep 0.07; $stdout.flush }
    puts ""
    puts "Desperate_level = #{desperate_level}"
    puts ""
  end
  if list_of_all_students_presence.count == 1
    pair_partner_1 = list_of_all_students_presence.sample
    "#{pair_partner_1.name}".each_char {|c| putc c ; sleep 0.07; $stdout.flush }
  end

end

def missing_students(list_of_all_students_missing)

  # Public:
  #
  # How it works/Example:
  #
  # list_of_all_students_missing = [student5, student6]
  # missing_students(list_of_all_students_missing)
  #
  # "Frånvarande:"
  # "student5.name"
  # "student6.name"
  #
  # end
  #
  # writes out each .name of the students in the list_of_all_students_missing until it reaches the end of the list
  #
  #

  puts ""
  puts ""
  puts "Frånvarande:"
  counter = 0
  until list_of_all_students_missing.count == counter
    puts list_of_all_students_missing[0 + counter].name
    counter += 1
    sleep 0.5
  end

end


def main

  list_of_all_students = student_list_maker
  list_of_all_students_presence = presence(list_of_all_students)
  pair_maker(list_of_all_students_presence)
  list_of_all_students_missing = not_presence(list_of_all_students, list_of_all_students_presence)
  missing_students(list_of_all_students_missing)

  puts ""
  puts ""
  puts "Thanks for using Slumpinator 3.5 Optimise Edition"
  end

main