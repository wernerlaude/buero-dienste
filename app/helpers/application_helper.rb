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
end
