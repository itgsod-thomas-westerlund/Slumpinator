require_relative 'student'

def student_list_maker

  # Public:
  #
  # <How it works/Example>
  # elev_list_maker
  # students.txt = Daniel_Berg 9
  #                Bosse_Python 8
  #
  # => list_of_all_students = [#<Student:0x007fe2ca020968>, #<Student:0x007fe2ca020238>]
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

def main

  list_of_all_students = student_list_maker



  number = 0
  lista = 0
  while lista < list_of_all_students.length
    lista += 1
    ropad = list_of_all_students[0 + number]
     #elever_list[0 + number]
    puts ""
    puts ropad.name

    y = gets.chomp
    if y == ""
      puts "Närvarande"
      number += 1
      list_of_all_missing_students.delete(ropad)
    else
      puts "Frånvarande"
      list_of_all_students.delete(ropad)
    end

  end

  while list_of_all_students.count >= 2
    good_pair = false
    pair1 = list_of_all_students.sample
    list_of_all_students.delete(pair1)
    partner_list = list_of_all_students.dup
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
          partner_list = list_of_all_students.dup
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


    list_of_all_students.delete(pair2)
    "#{pair1.name} + #{pair2.name} ".each_char {|c| putc c ; sleep 0.07; $stdout.flush }
    puts ""
    puts "Desperate_level = #{desperate_level}"
    puts ""
  end
  if list_of_all_students.count == 1
    pair1 = list_of_all_students.sample
    "#{pair1.name}".each_char {|c| putc c ; sleep 0.07; $stdout.flush }
  end
  puts ""
  puts ""
  puts "Frånvarande:"
  numberF = 0
  until list_of_all_missing_students.count == numberF
    puts list_of_all_missing_students[0 + numberF].name
    numberF += 1
    sleep 0.5
  end
  puts ""
  puts ""
  puts "Thanks for using Slumpinator 3.5 Optimise Edition"
  end

elev_list_maker