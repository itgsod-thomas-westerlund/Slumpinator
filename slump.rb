require_relative 'elever'

def slump2

  elever_list = []
  elever_list_f = []

  f = File.open('13.txt', 'r')
  f.each_line do |line|
    x = line.split(' ')
    elev = Elev.new(x.first, x.last)
    elever_list<<elev
    elever_list_f<<elev

  end
  number = 0
  lista = 0
  while lista < elever_list.length
    lista += 1
    ropad = elever_list[0 + number]
     #elever_list[0 + number]
    puts ""
    puts ropad.name

    y = gets.chomp
    if y == ""
      puts "Närvarande"
      number += 1
      elever_list_f.delete(ropad)
    else
      puts "Frånvarande"
      elever_list.delete(ropad)
    end

  end

  while elever_list.count >= 2
    good_pair = false
    pair1 = elever_list.sample
    elever_list.delete(pair1)
    partner_list = elever_list.dup
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
          partner_list = elever_list.dup
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


    elever_list.delete(pair2)
    "#{pair1.name} + #{pair2.name} ".each_char {|c| putc c ; sleep 0.07; $stdout.flush }
    puts ""
    puts "Desperate_level = #{desperate_level}"
    puts ""
  end
  if elever_list.count == 1
    pair1 = elever_list.sample
    "#{pair1.name}".each_char {|c| putc c ; sleep 0.07; $stdout.flush }
  end
  puts ""
  puts ""
  puts "Frånvarande:"
  numberF = 0
  until elever_list_f.count == numberF
    puts elever_list_f[0 + numberF].name
    numberF += 1
    sleep 0.5
  end
  puts ""
  puts ""
  puts "Thanks for using Slumpinator 3.5 Optimise Edition"
  end

#slump

slump2