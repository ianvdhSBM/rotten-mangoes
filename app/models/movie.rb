class Movie < ActiveRecord::Base

  scope :search, -> (query) { where("title LIKE :search OR director LIKE :search", search: "%#{query}%") }

  scope :runtime, -> (runtime) { where(runtime_search(runtime)) }

  has_many :reviews

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  mount_uploader :image, PosterUploader

  def review_average
    if reviews.size == 0
      "No reviews for this movie."
    else
      reviews.sum(:rating_out_of_ten)/reviews.size.to_f
    end
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end

  def self.runtime_search(choice)
    case choice
    when "0"
       ""
    when "1"
       "runtime_in_minutes < 90"
    when "2"
       "runtime_in_minutes BETWEEN 90 AND 120"
    when "3"
       "runtime_in_minutes > 120"
    end
  end

  # Used to check if params being passed from search is blank or not.
  # If not blank, it would add wildcards.
  # Decided to move .blank? to controller
  # def self.property_info(property)
  #   if property.blank?
  #     ''
  #   else
  #     "%#{property}%"
  #   end
  # end

end
