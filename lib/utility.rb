module Utility

# Dates
  def self.to_active_record(datetime)
    Time.strptime(datetime + Time.now.getlocal.zone, '%m/%d/%Y %I:%M %p %Z')
  end

  def self.from_active_record(datetime)
    unless datetime
      return nil
    end

    datetime = ActiveSupport::TimeZone.new('America/New_York').utc_to_local(datetime)
    datetime.strftime('%m/%d/%Y %I:%M %p')
  end
end
