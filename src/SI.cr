module SI
  PREFIXES = {
    -8 => "y", # yocto
    -7 => "z", # zepto
    -6 => "a", # atto
    -5 => "f", # femto
    -4 => "p", # pico
    -3 => "n", # nano
    -2 => "µ", # micro
    -1 => "m", # milli
     0 => "",
     1 => "k", # kilo
     2 => "M", # mega
     3 => "G", # giga
     4 => "T", # tera
     5 => "P", # peta
     6 => "E", # exa
     7 => "Z", # zetta
     8 => "Y", # yotta
  }

  EXPONENTS = {} of String => Int32

  PREFIXES.each do |k, v|
    EXPONENTS[v] = k
  end

  ALIASES = {
    "u" => "µ",
  }

  ALIASES.each do |newk, origk|
    EXPONENTS[newk] = EXPONENTS[origk]
  end

  PARSE_REGEX             = /^([\-0-9.]+)\s?([#{EXPONENTS.keys.join}])(.*)/
  PARSE_REGEX_NO_EXPONENT = /^([\-0-9.]+)\s?(.*)/

  def self.format(number, unit, separator = " ", base = 1000)
    return "#{number}#{separator}#{unit}" if number == 0
    is_negative = number < 0
    num = number.abs
    base = base.to_f
    exp = Math.log(num, base).floor.to_i
    prefix = PREFIXES[exp]
    scaled = num / (base ** exp)
    scaled *= -1 if is_negative
    scaled = scaled.to_s.chomp(".0")
    return "#{scaled}#{separator}#{prefix}#{unit}"
  end

  def self.parse(formatted, base = 1000)
    if m = PARSE_REGEX.match(formatted)
      num = m[1].to_f
      prefix = m[2]
      unit = m[3]
      base = base.to_f
      scaled = num * (base ** EXPONENTS[prefix])
      return scaled, unit
    end
    if m = PARSE_REGEX_NO_EXPONENT.match(formatted)
      num = m[1].to_f
      unit = m[2]
      return num, unit
    end
  end
end
