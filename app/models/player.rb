class Player < ApplicationRecord
  belongs_to :team
  FILTER_PARAMS = %i[name column direction].freeze

  validates :name, :seasons, presence: true

  scope :by_name, ->(query) { where('players.name like ?', "%#{query}%") }

  def self.filter(filters)
    Player.includes(:team)
          .by_name(filters['name'])
          .order("#{filters['column']} #{filters['direction']}")
  end
end
