class Admin::DashboardController < AdminController
  include Visitables

  def index
    get_besucheranzahl

    rows = ActiveRecord::Base.connection.execute(<<~SQL)
      SELECT DATE(viewed_at) as tag, COUNT(*) as besucher
      FROM page_views
      WHERE page_name = 'homepage'
      GROUP BY DATE(viewed_at)
      ORDER BY tag DESC
      LIMIT 30
    SQL

    @chart_data = rows.each_with_object({}) do |row, hash|
      hash[row[0].to_s] = row[1]
    end.sort.to_h
  end
end
