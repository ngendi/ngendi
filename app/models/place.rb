class Place < ActiveRecord::Base
  has_attached_file :photo, :styles => { :small => "200x150>", :thumb => "100x100>" },
							:url => "/assets/places/:id/:style/:basename.:extension",
							:path => ":rails_root/public/assets/places/:id/:style/:basename.:extension"
  acts_as_taggable

  acts_as_mappable	:default_units => :kms,
							:default_formula => :sphere,
							:distance_field_name => :distance,
							:lat_column_name => :latitude,
							:lng_column_name => :longitude

  validates :title, :presence => true
  validates :desc, :presence => true
  validates :address, :presence => true
  validates :phone, :presence => true
  validates :latitude, :presence => true
  validates :longitude, :presence => true
  validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']

  belongs_to :user
  belongs_to :category

  define_index do
    indexes tags.name, :as => :tags
    indexes category.name, :as => :category
    indexes :desc
    indexes :title
    indexes :address
    
    set_property :field_weight => {
      :category => 10,
      :title => 6,
      :tags => 4,
      :desc => 2,
      :address => 1
    }

    has "RADIANS(latitude)",  :as => :latitude,  :type => :float
    has "RADIANS(longitude)", :as => :longitude, :type => :float
  end

  scope :published, where("places.published_at IS NOT NULL")
  scope :draft, where("places.published_at IS NULL")
  scope :recent, lambda { published.where("place.published_at > ?", 1.week.ago.to_date) }
  scope :where_title, lambda { |term| where("places.title LIKE ?", "%#(term)%") }

  def long_title
    "#{title} - #{phone}"
  end

  def published?
    published_at.present?
  end

  def owned_by? (owner)
    return false unless owner.is_a? User
    user == owner
  end
end
