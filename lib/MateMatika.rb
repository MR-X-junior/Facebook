class Moya # Love You Moya  ><

  # MATEMATIKA ILMU YANG MEMATIKAN >< # 

  def initialize(number,precision = 0)
    @number = number
    @precision = precision
    @NEG_ENDINGS = { "''"=>"''", 'k'=>'m', 'M'=>'μ', 'G'=>'n', 'T'=>'p','P'=>'f', 'E'=>'a', 'Z'=>'z', 'Y'=>'y' }
  end

  def convert!
    raise ArgumentError, "Absolute value too big!" if @number.abs >= 10**27
    raise ArgumentError, "Precision out-of-range" unless (0..3).cover?(@precision)
    if @number.abs < 1000
      "#{@number}"
    else
      val = recurse(@number.abs)
      (@number >= 0) ? val : "-#{val[0..-2]}#{@NEG_ENDINGS[val[-1]]}"
    end        
  end

  def recurse(num,endings = %w|k M G T P E Z Y| )
    suffix = endings.shift
    x,n = num.divmod(1000)
    if x < 1000
      unless @precision.zero?
        x = "%.#{@precision}f" % (x + n/1000.0)
      end  
      return "#{ x }#{ suffix }"
    end
    recurse(x, endings)
  end

  private :recurse

end

