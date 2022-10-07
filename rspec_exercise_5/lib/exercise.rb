require "byebug"

array_1 = ['a', 'b', 'c']
array_2 = [1, 2, 3]
array_3 = ['w', 'x', 'y']
array_4 = ['v', 'w', 'x', 'y', 'z']
div_3 = Proc.new { |n| n % 3 == 0 }
div_5 = Proc.new { |n| n % 5 == 0 }
ends_ly = Proc.new { |s| s.end_with?('ly') }
has_i = Proc.new { |s| s.include?('i') }

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