class MoviesController < ApplicationController
  def index
    query = params['query']

    if query.present?
      # sql_subquery = "title ILIKE ? OR synopsis ILIKE ?"

      sql_subquery = "
      movies.title @@ '#{query}'
      OR movies.synopsis @@ '#{query}'
      OR directors.first_name @@ '#{query}'
      OR directors.last_name @@ '#{query}'
      "

      @movies = Movie.joins(:director)
      @movies = @movies.where(sql_subquery)
    else
      @movies = Movie.all
    end

  end
end
