module Johan
  class Math
    class << self
      def median(arr)
        arr.sort[arr.count/2]
      end
    end
  end
end
