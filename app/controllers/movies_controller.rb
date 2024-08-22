class MoviesController < ApplicationController
  def index
    query = params['query']

    if query.present?
      ## ------- Method 1 ------- :
      ## Single Table 2 field query (with ILIKE operator - case Insensitive LIKE) - to be called on movies table

      # sql_subquery = "title ILIKE ? OR synopsis ILIKE ?"
      # @movies = Movie.where(sql_subquery, query, query) # execute where with subquery passing in query as paramter

      ## ------- Method 2 ------- :
      ## 2 Table 4 field query (with LIKE operator) - to be called on a joined collection

      ## note for query below: '':query' is a reference to a named param that will be passed into the .where method

      # sql_subquery = "movies.title ILIKE :query OR movies.synopsis ILIKE :query
      #                 OR directors.first_name ILIKE :query OR directors.last_name ILIKE :query"

      ## Active Record Syntax for joining directors table to movies using matching ON directors.id = movies.director_id
      # @movies = Movie.joins(:director)

      # @movies = @movies.where(sql_subquery, query: query) # execute where with subquery passing in query as NAMED parameter

      ## ------- Method 3 ------- :
      ## 2 Table Full Text Search (with @@ operator) (PostreSQL syntax) query

      # sql_subquery = "
      # movies.title @@ :query
      # OR movies.synopsis @@ :query
      # OR directors.first_name @@ :query
      # OR directors.last_name @@ :query
      # "

      # @movies = Movie.joins(:director)
      # @movies = @movies.where(sql_subquery, query: query)

      ## ------- Method 4 ------- :
      ## Single Table Full Text Search (with partial matching) with pg_search gem, class method defined in app/models/movie.rb
      # @movies = Movie.search_by_title_and_synopsis(query)

      ## ------- Method 5 ------- :
      ## 2 Table Full Text Search (with partial matching) with pg_search gem, class method defined in app/models/movie.rb
      # @movies = Movie.global_search(query)
    else
      # if no query available to be searched with get all Movies as usual
      @movies = Movie.all
    end

  end
end
