# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://www.buero-dienstleistungen.com/"

SitemapGenerator::Sitemap.create do
  # 👉 Statische Seiten
  add root_path, changefreq: "daily", priority: 1.0
  add datenschutz_path, changefreq: "yearly"
  add impressum_path, changefreq: "yearly"
  # add werbung_path, changefreq: "weekly"                # /werbung-schalten
  # add ihre_visitenkarte_path, changefreq: "monthly"     # /ihre-visitenkarte
  add hilfreiche_links_path, changefreq: "monthly"      # /hilfreiche-links
  add faq_path, changefreq: "weekly"                    # /fragen-und-atworten

  # 👉 Blogs (office-blog_posts)
  BlogPost.find_each do |blog_post|
    add blog_post_path(blog_post), lastmod: blog_post.updated_at, changefreq: "weekly"
  end

  # 👉 Bundesländer (bueroservice-in-ihrem-bundeslands)
  Bundesland.find_each do |bundesland|
    add bundesland_path(bundesland), lastmod: bundesland.updated_at, changefreq: "weekly"
  end

  # 👉 Angebote (angebot)
  Offer.find_each do |offer|
    add offer_path(offer), lastmod: offer.updated_at, changefreq: "weekly"
  end

  # 👉 Nutzer (ihr-partner) – nur show!
  User.find_each do |user|
    add user_path(user), lastmod: user.updated_at, changefreq: "weekly"
  end
end
