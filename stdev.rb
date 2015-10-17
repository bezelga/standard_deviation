require 'ffi'

module StandardDeviation
  extend FFI::Library
  ffi_lib 'target/release/libstandard_deviation.dylib'
  attach_function :stdev, [:pointer], :double

  def self.stvdev_ruby(values)
    size = values.length
    mean = values.reduce(:+) / values.length

    distances = values.map do |value|
      (value - mean) ** 2
    end

    distance = distances.reduce(:+)

    variance = distance / (size - 1)

    Math.sqrt(variance)
  end
end

values = [1, 2, 6, 3, -4, 23]

p = FFI::MemoryPointer.new(:int, values.size)
p.write_array_of_int(values)

puts "Before qsort #{p.get_array_of_int32(0, values.size).join(', ')}"

puts StandardDeviation.stdev(p)

