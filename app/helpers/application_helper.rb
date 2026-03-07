module ApplicationHelper
  def card_badge(card)
    if card.try(:featured?) || card.users.size > 50
      content_tag(:span, "Beliebt", class: "category-card__badge category-card__badge--top")
    elsif card.users.size > 30
      content_tag(:span, "Gefragt", class: "category-card__badge category-card__badge--hot")
    elsif card.users.size == 0
      content_tag(:span, "Neu", class: "category-card__badge category-card__badge--new")
    end
  end

  def format_text(content)
    content.to_s.html_safe
  end

  def random_css_class
    %w[filter-green filter-blue filter-safran].sample
  end

  def icon(name, options = {})
    size = options[:size] || 24
    css_class = options[:class] || ""
    lucide_icon(name.to_s.dasherize, class: css_class, size: size)
  end

  def gender(user)
    return "Neuer Partner" if user == "Herr"
    return "Neue Partnerin" if user == "Frau"
    "Firma"
  end

  def safe_webpage_link(url, options = {})
    return nil unless url.present?

    # Explizite Prüfung, die Brakeman versteht
    sanitized_url = Rack::Utils.escape_html(url)

    # Merge default options mit übergebenen options
    default_options = { target: "_blank", rel: "noopener noreferrer" }
    link_to sanitized_url, sanitized_url, default_options.merge(options)
  end
end
