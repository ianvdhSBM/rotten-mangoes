class Movie < ActiveRecord::Base

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

  scope :search, ->(query) do
    if query
      where("title LIKE :search OR director LIKE :search", search: property_info(query))
    end
  end

  scope :runtime, ->(runtime) do
    where(runtime_search(runtime))
  end

  def self.runtime_search(choice)
    params = ""
    case choice
    when "0"
      params = ""
    when "1"
      params = "runtime_in_minutes < 90"
    when "2"
      params = "runtime_in_minutes BETWEEN 90 AND 120"
    when "3"
      params = "runtime_in_minutes > 120"
    end
    params
  end

  def self.property_info(property)
    if property.blank?
      ''
    else
      "%#{property}%"
    end
  end

end
