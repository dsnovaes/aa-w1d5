require "byebug"

def duos(str)
    count = 0
    str.each_char.with_index do |char,i|
        count += 1 if str[i] == str[i+1]
    end
    count
end

# p duos('bootcamp')      # 1
# p duos('wxxyzz')        # 2
# p duos('hoooraay')      # 3
# p duos('dinosaurs')     # 0
# p duos('e')             # 0

def sentence_swap(sentence,hash)
    arr = sentence.split(" ")
    arr.map! { |word| hash.has_key?(word) ? hash[word] : word }
    arr.join(" ")
end

# p sentence_swap('anything you can do I can do',
#     'anything'=>'nothing', 'do'=>'drink', 'can'=>'shall'
# ) # 'nothing you shall drink I shall drink'

# p sentence_swap('what a sad ad',
#     'cat'=>'dog', 'sad'=>'happy', 'what'=>'make'
# ) # 'make a happy ad'

# p sentence_swap('keep coding okay',
#     'coding'=>'running', 'kay'=>'pen'
# ) # 'keep running okay'

def hash_mapped(hash, prc, &blk)
    new_hash = {}
    hash.each do |k,v|
        new_hash[blk.call(k)] = prc.call(v)
    end
    new_hash
end

# double = Proc.new { |n| n * 2 }
# p hash_mapped({'a'=>4, 'x'=>7, 'c'=>-3}, double) { |k| k.upcase + '!!' }
# # {"A!!"=>8, "X!!"=>14, "C!!"=>-6}

# first = Proc.new { |a| a[0] }
# p hash_mapped({-5=>['q', 'r', 's'], 6=>['w', 'x']}, first) { |n| n * n }
# # {25=>"q", 36=>"w"}

def counted_characters(sentence)
    count = Hash.new(0)
    sentence.each_char { |char| count[char] += 1 }
    result = []
    count.select { |k,v| v > 2  }.each { |k,v| result << k }
    result
    
end

# p counted_characters("that's alright folks") # ["t"]
# p counted_characters("mississippi") # ["i", "s"]
# p counted_characters("hot potato soup please") # ["o", "t", " ", "p"]
# p counted_characters("runtime") # []

def triplet_true?(str)
    str.each_char.with_index do |char,i|
        if str[i+2] == str[i] && str[i] == str[i+1] # coulb be written also as str[i..i+2] == str[i] * 3
            return true
        end
    end
    return false
end

# p triplet_true?('caaabb')        # true
# p triplet_true?('terrrrrible')   # true
# p triplet_true?('runninggg')     # true
# p triplet_true?('bootcamp')      # false
# p triplet_true?('e')             # false

# Write a method energetic_encoding that accepts a string and a hash as arguments. 
# The method should return a new string where characters of the original string 
# are replaced with the corresponding values in the hash. If a character is not a key 
# of the hash, then it should be replaced with a question mark ('?'). 
# Space characters (' ') should remain unchanged.

def energetic_encoding(str, hash)
    new_str = ""
    str.each_char do |char|
        if char == " "
            new_str += " "
        elsif hash.has_key?(char)
            new_str += hash[char]   
        else
            new_str += "?"
        end
    end
    new_str
end

# p energetic_encoding('sent sea',
#     'e'=>'i', 's'=>'z', 'n'=>'m', 't'=>'p', 'a'=>'u'
# ) # 'zimp ziu'

# p energetic_encoding('cat',
#     'a'=>'o', 'c'=>'k'
# ) # 'ko?'

# p energetic_encoding('hello world',
#     'o'=>'i', 'l'=>'r', 'e'=>'a'
# ) # '?arri ?i?r?'

# p energetic_encoding('bike', {}) # '????'


def uncompress(str)
    new_str = ""
    str.each_char.with_index { |char,i| new_str += char * str[i+1].to_i if i % 2 == 0 }
    new_str
end

# p uncompress('a2b4c1') # 'aabbbbc'
# p uncompress('b1o2t1') # 'boot'
# p uncompress('x3y1x2z4') # 'xxxyxxzzzz'