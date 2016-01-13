class GroupEvent < ActiveRecord::Base
  scope :unmarked, -> { where(is_destroyed: false) }

  validates :name,        length: { maximum: 256 }
  validates :description, length: { maximum: 1024 }
  validates :location,    length: { maximum: 256 }
  validates :duration, numericality: { only_integer: true,
                                       greater_than: 0 },
                       unless: "duration.nil?"             

  validate :start_date_precedes_end_date

  before_save :calculate_expiration, unless: "starts_at.nil?"

  def publish
    if all_fields_set?
      self.is_published = true
      save
    end
  end

  def all_fields_set?
    to_check = %w[name description location starts_at ends_at duration]
    
    to_check.each do |attr_name|
      return false if self.attributes[attr_name].nil?
    end

    true
  end

  def mark_as_destroyed
    self.is_destroyed = true
    save
  end


  private

    def calculate_expiration
      if self.duration
        self.ends_at = self.starts_at + self.duration 
      elsif self.ends_at
        self.duration = (self.ends_at - self.starts_at).to_i
      end
    end

    def start_date_precedes_end_date
      if self.starts_at && self.ends_at
        errors.add(:ends_at, 'is invalid') if starts_at > ends_at
      end
    end

end
