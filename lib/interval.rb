class Interval
  attr_accessor :from, :to, :kind

  def initialize(kind, date = nil)
    @kind = kind
    @date = date
  end

  def from
    date.send("beginning_of_#{kind}")
  end

  def to
    date.send("end_of_#{kind}")
  end

  def date
    @date || Date.today
  end

  def to_hash
    { kind: kind,  from: from_string,  to: to_string  }
  end

  def from_string
    from.strftime('%Y%m%d')
  end

  def to_string
    to.strftime('%Y%m%d')
  end

  def name
    kind.to_s.humanize
  end

  def previous
    Interval.new(kind, from - 1.send(kind))
  end

  def next
    Interval.new(kind, from + 1.send(kind))
  end

end

