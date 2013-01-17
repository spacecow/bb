module Johan
  class Time
    class << self
      def seconds(date)
        date.to_i - date.beginning_of_day.to_i
      end
    end
  end
end
