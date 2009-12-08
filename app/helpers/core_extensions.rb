require 'date'

class Date
  def formatted_month
    return self.strftime("%B")
  end
end

class Float
  def to_decimal
    return (self / 100)
  end
  def to_percentage
    return ("%0.0f%" % (self * 100))
  end
end