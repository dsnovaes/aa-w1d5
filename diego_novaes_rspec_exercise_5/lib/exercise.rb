require "byebug"

$vowels = "aeiouAEIOU"

array_1 = ['a', 'b', 'c']
array_2 = [1, 2, 3]
array_3 = ['w', 'x', 'y']
array_4 = ['v', 'w', 'x', 'y', 'z']
div_3 = Proc.new { |n| n % 3 == 0 }
div_5 = Proc.new { |n| n % 5 == 0 }
ends_ly = Proc.new { |s| s.end_with?('ly') }
has_i = Proc.new { |s| s.include?('i') }
array_5 = ['mouse', 'dog', 'goat', 'bird', 'cat']
array_6 =  [1, 2, 9, 30, 11, 38] 
array_7 = ['potato', 'swimming', 'cat']
array_8 = ['cat', 'bootcamp', 'swimming', 'ooooo']
array_9 = ['photo','bottle', 'bother']
length = Proc.new { |s| s.length }
o_count = Proc.new { |s| s.count('o') }

#############################################

def zip(*arrays)

    # my solution
    result = Array.new(arrays[0].count) { Array.new(arrays.length) }
    arrays.each_with_index do |array,ai|
        array.each_with_index do |ele,idx| 
            result[idx][ai] = ele
        end
    end
    result

    # given answer in the solutions file

    # length = arrays.first.length

    # (0...length).map do |i|
    #     arrays.map do |array| 
    #         array[i]
    #     end
    # end

end

# p zip(array_1, array_2)
# p zip(array_2, array_1)
# p zip(array_1, array_2, array_3)

def prizz_proc(arr, prc1, prc2)
    arr.select { |ele| prc1.call(ele) ^ prc2.call(ele) }
end

# p prizz_proc([10, 9, 3, 45, 12, 15], div_3, div_5) # [10, 9, 3, 12]
# p prizz_proc(
#     ['honestly', 'sully', 'sickly', 'trick', 'doggo', 'quickly'],
#     ends_ly,
#     has_i
# ) # ['honestly', 'sully', 'trick']

def zany_zip(*arrays)
    max = []
    arrays.each { |array| max << array.length }
    # debugger
    result = Array.new(arrays.count) { Array.new(max.max, nil) }
    # arrays.each_with_index do |array,ai|
    #     array.each_with_index do |ele,idx| 
    #         # debugger
    #         result[idx][ai] = ele
    #     end
    # end
    result
end

# p zany_zip(array_3, array_2, array_4)


def maximum(arr, &prc)
    return nil if arr.empty?

    # my solution
    result = Hash.new(0)
    arr.each_with_index { |ele,i| result[i] = prc.call(ele) }
    i = result.sort_by { |k,v| v }[-1][0]
    arr[i]

    # given answer in the solutions file
    # max = array.first
    # array.each do |el|
    #     max = el if prc.call(el) >= prc.call(max)
    # end
    # max

end

# p maximum([2, 4, -5, 1]) { |n| n * n } # => -5
# p maximum(['potato', 'swimming', 'cat']) { |w| w.length } # => swimming
# p maximum(['boot', 'cat', 'drop']) { |w| w.length } # => drop

def my_group_by(arr, &prc)
    result = Hash.new { |h, k| h[k] = [] }
    arr.each { |ele| result[prc.call(ele)] << ele  }
    result
end

# p my_group_by(array_5) { |s| s.length }

def max_tie_breaker(arr, prc, &blk)
    max = arr[0]
    arr.each do |ele| 
        # debugger
        b_e = blk.call(ele)
        b_m = blk.call(max)
        if b_e == b_m
            prc_e = prc.call(ele)
            prc_m = prc.call(max)
            if prc_e > prc_m
                ele
            end
        elsif b_e > b_m
            max = ele
        end
    end
    max
end

# p max_tie_breaker(array_7, o_count, &length) # => swimming
# p max_tie_breaker(array_8, length, &o_count) # => ooooo
# p max_tie_breaker(array_8, o_count, &length) # => bootcamp
# p max_tie_breaker(array_9, o_count, &length) # => bottle
# p max_tie_breaker([], o_count, &length) # => nil

def silly_syllables(sentence)
    arr = sentence.split(" ")
    result = []
    arr.each do |word| 
        if vowel_count(word) < 2
            result << word
        else
            # result << word.slice(first_vowel(word),last_vowel(word))
            result << word[first_vowel(word)..last_vowel(word)]
        end
    end
    result.join(" ")
end

def first_vowel(str)
    str.each_char.with_index { |char,i| return i if $vowels.include?(char) }
    return 0
end

def last_vowel(str)
    # i = 0
    # (0...str.length).each do |x|
    #     i = x if $vowels.include?(str[x])
    # end
    # i

    i = str.length - 1
    while i > 0
        if $vowels.include?(str[i])
            return i
        end
        i -=1
    end
    i
end

def vowel_count(str)
    count = 0
    str.each_char { |char| count += 1 if $vowels.include?(char) }
    count
end

# p silly_syllables('properly precisely written code') # => ope ecise itte ode
# p silly_syllables('trashcans collect garbage') # => ashca olle arbage
# p silly_syllables('properly and precisely written code') # => ope and ecise itte ode
# p silly_syllables('the trashcans collect all my garbage') # => the ashca olle all my arbage