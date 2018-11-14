class DashboardController < ApplicationController
  def index
    @latest_scene = Post.all.try(:last).try(:scene)
    @latest_story = @latest_scene.try(:story)

    @chart_globals = chart_globals
    @post_chart = post_counts_chart
    @genre_chart = genre_breakdown_chart
  end

  private

  def chart_globals
    grid_color = 'rgba(255,255,255,0.1)'
    label_color = 'rgba(255,255,255,0.75)'
    pie_color = '#282828'

    LazyHighCharts::HighChartGlobals.new do |f|
      f.chart(
        background_color: 'transparent',
        style: {
          font_family: "Roboto, 'Helvetica-Neue', Arial, sans-serif"
        }
      )
      f.plot_options(
        pie: { border_color: nil }
      )
      f.tooltip(
        background_color: 'rgba(0,0,0,.7)',
        style: { color: '#EEEEEE' }
      )
      f.x_axis(
        grid_line_color: grid_color,
        line_color: grid_color,
        minor_grid_line_color: grid_color,
        tick_color: grid_color,
        labels: { style: { color: label_color } },
        title: { style: { color: label_color } }
      )
      f.y_axis(
        grid_line_color: grid_color,
        line_color: grid_color,
        minor_grid_line_color: grid_color,
        tick_color: grid_color,
        labels: { style: { color: label_color } },
        title: { style: { color: label_color } }
      )
      f.legend(
        item_style: { color: label_color },
        item_hover_style: { color: '#FFFFFF' },
        item_hidden_style: { color: grid_color }
      )
      f.colors([
        '#F44336',
        '#E91E63',
        '#9C27B0',
        '#673AB7',
        '#3F51B5',
        '#2196F3',
        '#03A9F4',
        '#00BCD4',
        '#009688',
        '#4CAF50',
        '#8BC34A',
        '#CDDC39',
        '#FFEB3B',
        '#FFC107',
        '#FF9800',
        '#FF5722',
        ])
    end
  end

  def post_counts_chart
    # Get raw post data
    posts = Post.unscoped.where(
      created_at: (7.days.ago.beginning_of_day)..(Time.zone.now.end_of_day)
    )
    post_counts = posts.group_by_day(:created_at).count

    # Get main series
    dates = (Date.today - 7)..Date.today
    date_series = Hash[dates.collect { |v| [v, post_counts[v] || 0] }]

    # Get user series
    user_post_series = { }
    User.all.each do |user|
      counts = posts.where(user: user).group_by_day(:created_at).count
      array = dates.each.map { |d| counts[d] || 0 }
      user_post_series[user.name] = array
    end

    LazyHighCharts::HighChart.new('area') do |f|
      f.chart({type: 'line'})
      f.x_axis(
        categories: date_series.keys.collect { |k| k.strftime('%A<br>%b %e') },
        title: { text: 'Date' }
      )
      f.y_axis(
        title: { text: '# of posts' }
      )

      user_post_series.each do |name, data|
        f.series(
          name: name + "'s Posts",
          data: data,
          marker: { symbol: 'circle' }
        )
      end

      f.series(
        name: 'Total Posts',
        data: date_series.values,
        line_width: 3,
        marker: { symbol: 'square' }
      )
    end
  end

  def genre_breakdown_chart
    genres = Genre.joins(:stories).group('genres.id').map { |g| { name: g.name, y: g.stories.count } }

    LazyHighCharts::HighChart.new('pie') do |f|
      f.series(
        name: 'Stories',
        color_by_point: true,
        data: genres
        )
      f.plot_options({
        pie: {
          data_labels: {
            enabled: false
          },
          show_in_legend: true
        }
      })
      f.chart({type: 'pie'})
    end
  end

end
