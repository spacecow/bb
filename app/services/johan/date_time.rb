module Johan
  class DateTime
    class << self
      def new(date)
        date = ::Date.parse date if date.instance_of? String
        date + Johan::Time.seconds(::Time.zone.now).second
      end
    end
  end
end
