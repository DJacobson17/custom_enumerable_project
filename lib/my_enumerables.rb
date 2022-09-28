module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    for each in self do
      yield each
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index, *args) unless block_given?

    i = 0
    for each in self do
      yield each, i
      i += 1
    end
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    result = []
    my_each { |item| result << item if yield item }
    result
  end

  def my_all?
    if block_given?
      my_each { |item| return false unless yield item }
    else
      for each in self
        return false unless each
      end
    end
    true
  end

  def my_any?
    if block_given?
      my_each { |item| return true if yield item}
    else
      for each in self
        return true if each
      end
    end
    false
  end

  def my_none?
    if block_given?
      my_each { |item| return false if yield item }
    else
      for each in self
        return false if each
      end
    end
    true
  end

  def my_count
    return size unless block_given?

    c = 0
    my_each { |item| c += 1 if yield item}
    c
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    arr = []
    my_each { |item| arr << yield(item) }
    arr
  end

  def my_inject(args)
    sum = args ? args : self.first
    my_each { |item| sum = yield(sum, item) }
    sum
  end


  # You will first have to define my_each
  # on the Array class. Methods defined in
  # your enumerable module will have access
  # to this method
end
