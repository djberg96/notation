# notation_parser.y - RACC grammar file for Unicode notation

class NotationParser
rule
  expr: comparison
      | unary_op
      | number
      | '(' expr ')'  { result = val[1] }

  comparison: number GTE number    { result = ≥(val[0], val[2]) }
            | number LTE number    { result = ≤(val[0], val[2]) }
            | number NEQ number    { result = ≠(val[0], val[2]) }
            | number APPROX number { result = ≈(val[0], val[2]) }
            | number '>' number    { result = val[0] > val[2] }
            | number '<' number    { result = val[0] < val[2] }
            | number GE number     { result = val[0] >= val[2] }
            | number LE number     { result = val[0] <= val[2] }

  unary_op: SQRT number      { result = √(val[1]) }
          | CBRT number      { result = ∛(val[1]) }
          | FRRT number      { result = ∜(val[1]) }
          | FACT number      { result = ！(val[1].to_i) }
          | ABS number       { result = ｜(val[1]) }

  number: INTEGER { result = val[0].to_i }
        | FLOAT   { result = val[0].to_f }
end

---- header
require_relative 'lib/notation'

---- inner
  def parse(str)
    @tokens = []
    str = str.strip

    until str.empty?
      case str
      when /\A\s+/
        str = $'
      when /\A\d+\.\d+/
        @tokens << [:FLOAT, $&]
        str = $'
      when /\A\d+/
        @tokens << [:INTEGER, $&]
        str = $'
      when /\A≥/
        @tokens << [:GTE, $&]
        str = $'
      when /\A≤/
        @tokens << [:LTE, $&]
        str = $'
      when /\A≠/
        @tokens << [:NEQ, $&]
        str = $'
      when /\A≈/
        @tokens << [:APPROX, $&]
        str = $'
      when /\A√/
        @tokens << [:SQRT, $&]
        str = $'
      when /\A∛/
        @tokens << [:CBRT, $&]
        str = $'
      when /\A∜/
        @tokens << [:FRRT, $&]
        str = $'
      when /\A！/
        @tokens << [:FACT, $&]
        str = $'
      when /\A｜/
        @tokens << [:ABS, $&]
        str = $'
      when /\A>=/
        @tokens << [:GE, $&]
        str = $'
      when /\A<=/
        @tokens << [:LE, $&]
        str = $'
      when /\A./
        @tokens << [$&, $&]
        str = $'
      end
    end

    @tokens << [false, false]
    @index = 0
    do_parse
  end

  def next_token
    @tokens[@index].tap { @index += 1 }
  end

---- footer

# Example usage:
if __FILE__ == $0
  parser = NotationParser.new

  test_cases = [
    "10 ≥ 5",
    "5 ≤ 10",
    "5 ≠ 3",
    "√ 49",
    "！ 5",
    "∛ 27",
    "∜ 16"
  ]

  test_cases.each do |test|
    puts "Testing: #{test}"
    begin
      result = parser.parse(test)
      puts "Result: #{result}"
    rescue => e
      puts "Error: #{e.message}"
    end
    puts
  end
end
