module Johan
  class Date
    class << self
      def interval(arr)
        (arr.first.to_date..arr.last.to_date).to_a
      end
    end
  end
end
