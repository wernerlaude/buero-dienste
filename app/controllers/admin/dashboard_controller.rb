class Admin::DashboardController < AdminController
  include Visitables

  def index
    begin
      # Chat Analytics Stats
      @chat_stats = {
        total: ChatAnalytic.count,
        today: ChatAnalytic.where("created_at >= ?", Date.current).count,
        answered_rate: calculate_answer_rate,
        needs_attention: ChatAnalytic.where(query_type: %w[fallback off_topic]).count
      }

      # @views_by_page = PageView.group(:page_name).count



      # Recent Activities
      @recent_activities = recent_activities

      # AnzahlBesucher
      @visits = get_besucheranzahl

    rescue => e
      Rails.logger.error "Error loading dashboard: #{e.message}"
      @chat_stats = { total: 0, today: 0, answered_rate: 0, needs_attention: 0 }
      @recent_activities = []
      flash.now[:alert] = "Fehler beim Laden der Dashboard-Daten."
    end

    get_besucheranzahl
  end

  private

  def calculate_answer_rate
    total = ChatAnalytic.count
    return 0 if total == 0

    answered = ChatAnalytic.where(query_type: "answered").count
    (answered.to_f / total * 100).round(1)
  end

  def recent_activities
    activities = []

    # Letzte Chat Analytics
    ChatAnalytic.limit(5).order(created_at: :desc).each do |chat|
      activities << {
        type: "chat_analytic",
        title: "Chat: #{chat.query.truncate(50)}",
        status: chat.query_type,
        time: chat.created_at
      }
    end

    activities.sort_by { |a| a[:time] }.reverse.first(10)
  end
end
