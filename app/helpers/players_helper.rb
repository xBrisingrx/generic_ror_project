module PlayersHelper
  def build_order_link(column:, label:)
    if column == session.dig('player_filters', 'column')
      link_to(label, list_players_path(column: column, direction: next_direction))
    else
      link_to(label, list_players_path(column: column, direction: 'asc'))
    end
  end
  
  def next_direction
    params[:direction] == 'asc' ? 'desc' : 'asc'
  end

  def sort_indicator
    if params[:direction] == "asc"
      content_tag(:span, "<svg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke-width='1.5' stroke='currentColor' class='w-6 h-6'>
        <path stroke-linecap='round' stroke-linejoin='round' d='M15 11.25l-3-3m0 0l-3 3m3-3v7.5M21 12a9 9 0 11-18 0 9 9 0 0118 0z' />
      </svg>".html_safe, class: "absolute top-1 left-0")
      elsif params[:direction] == "desc"
        content_tag(:span, "<svg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke-width='1.5' stroke='currentColor' class='w-6 h-6'>
          <path stroke-linecap='round' stroke-linejoin='round' d='M9 12.75l3 3m0 0l3-3m-3 3v-7.5M21 12a9 9 0 11-18 0 9 9 0 0118 0z' />
        </svg>".html_safe, class: "absolute top-1 left-0")
    end
  end
end