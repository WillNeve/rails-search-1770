class Movie < ApplicationRecord
  belongs_to :director

  include PgSearch::Model # inline inheritance
  multisearchable against: [:title, :synopsis]

  pg_search_scope :search_by_title_and_synopsis, # with pg_search we can define custom Class methods that handle deep searching
  against: [ :title, :synopsis ],
  using: {
    tsearch: { prefix: true }
  }

  pg_search_scope :global_search,
  against: [ :title, :synopsis ],
  associated_against: {
    director: [ :first_name, :last_name ]
  },
  using: {
    tsearch: { prefix: true }
  }
end
