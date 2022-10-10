require "byebug"
$vowels = "aeiou"

def conjunct_select(arr, *prc)
    result = []
    arr.each do |ele|
        temp_true = 0
        prc.each { |p| temp_true += 1 if p.call(ele) }
        result << ele if prc.length == temp_true
    end
    result
end

is_positive = Proc.new { |n| n > 0 }
is_odd = Proc.new { |n| n.odd? }
less_than_ten = Proc.new { |n| n < 10 }

# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive) # [4, 8, 11, 7, 13]
# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd) # [11, 7, 13]
# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd, less_than_ten) # [7]

def first_vowel(word)
    word.each_char.with_index { |char,i| return i if $vowels.include?(char) }
    return false
end

def ends_with_vowel?(word)
    return true if $vowels.include?(word[-1])
    false
end

def ayyay(str) 
    $vowels.include?(str[0]) ? str + "yay" : str[first_vowel(str)..-1] + str[0...first_vowel(str)] + "ay"
end

def convert_pig_latin(sentence)
    arr = sentence.split(" ")
    arr.map! do |word|
        # debugger
        if word.length < 3
            word
        else
            capitalized = word.capitalize == word
            if capitalized
                ayyay(word.downcase).capitalize!
            else
                ayyay(word.downcase) 
            end
        end
    end
    arr.join(" ")
end

# p convert_pig_latin('We like to eat bananas') # "We ikelay to eatyay ananasbay"
# p convert_pig_latin('I cannot find the trash') # "I annotcay indfay ethay ashtray"
# p convert_pig_latin('What an interesting problem') # "Atwhay an interestingyay oblempray"
# p convert_pig_latin('Her family flew to France') # "Erhay amilyfay ewflay to Ancefray"
# p convert_pig_latin('Our family flew to France') # "Ouryay amilyfay ewflay to Ancefray"

def last_vowel(str)
    i = str.length - 1
    while i > 0
        if $vowels.include?(str[i])
            return i
        end
        i -=1
    end
    i
end

def reverberate_word(str)
    if $vowels.include?(str[-1])
        str+str
    else
        str + str[last_vowel(str)..-1]
    end
end

def reverberate(sentence)
    arr = sentence.split(" ")
    arr.map! do |word|
        # debugger
        if word.length < 3
            word
        else
            capitalized = word.capitalize == word
            if capitalized
                reverberate_word(word).capitalize
            else
                reverberate_word(word)
            end
        end
    end
    arr.join(" ")

end

# p reverberate('We like to go running fast') # "We likelike to go runninging fastast"
# p reverberate('He cannot find the trash') # "He cannotot findind thethe trashash"
# p reverberate('Pasta is my favorite dish') # "Pastapasta is my favoritefavorite dishish"
# p reverberate('Her family flew to France') # "Herer familyily flewew to Francefrance"

def disjunct_select(arr, *prcs)
    result = []
    arr.each do |ele|
        prcs.each { |p| result << ele if p.call(ele) }
    end
    result.uniq
end

longer_four = Proc.new { |s| s.length > 4 }
contains_o = Proc.new { |s| s.include?('o') }
starts_a = Proc.new { |s| s[0] == 'a' }

# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
# ) # ["apple", "teeming"]

# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
#     contains_o
# ) # ["dog", "apple", "teeming", "boot"]

# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
#     contains_o,
#     starts_a
# ) # ["ace", "dog", "apple", "teeming", "boot"]

def alternating_vowel(sentence)
    arr = sentence.split(" ")
    arr.map!.with_index do |word,i|
        # debugger
        if !first_vowel(word)
            word
        elsif i % 2 == 0
            remove = first_vowel(word)
            word.slice(0,remove)+word.slice(remove+1,word.length-1)
        else
            remove = last_vowel(word)
            word.slice(0,remove)+word.slice(remove+1,word.length-1)
        end 
    end
    arr.join(" ")
end

# p alternating_vowel('panthers are great animals') # "pnthers ar grat animls"
# p alternating_vowel('running panthers are epic') # "rnning panthrs re epc"
# p alternating_vowel('code properly please') # "cde proprly plase"
# p alternating_vowel('my forecast predicts rain today') # "my forecst prdicts ran tday"

def insert_b(word)
    # word.each_char.with_index do |char,i|
    #     if $vowels.include?(char)
    #         word.insert(i,char+"b")
    #     end
    # end
    # word
    new_word = ""
    word.each_char do |char|
        if $vowels.include?(char)
            new_word += char + "b" + char
        else
            new_word += char
        end
    end
    new_word
end

def silly_talk(sentence)
    arr = sentence.split(" ")
    arr.map! do |word|
        if $vowels.include?(word[-1])
            word.insert(-1,word[-1])
        else
            insert_b(word)
        end
    end
    arr.join(" ")
end

# p silly_talk('Kids like cats and dogs') # "Kibids likee cabats aband dobogs"
# p silly_talk('Stop that scooter') # "Stobop thabat scobooboteber"
# p silly_talk('They can code') # "Thebey caban codee"
# p silly_talk('He flew to Italy') # "Hee flebew too Ibitabaly"

def compress(str)
    arr = str.split("")
    result = ""
    count = 1
    arr.each_with_index do |ele,i| 
        if ele == arr[i+1]
            count += 1
        else
            result += ele + count.to_s if count > 1
            result += ele if count == 1
            count = 1
        end
    end
    result
end

# p compress('aabbbbc')   # "a2b4c"
# p compress('boot')      # "bo2t"
# p compress('xxxyxxzzzz')# "x3yx2z4"