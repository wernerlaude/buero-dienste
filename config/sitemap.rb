require "rubygems"
require "sitemap_generator"

SitemapGenerator::Sitemap.default_host = "https://www.buero-dienstleistungen.com"

SitemapGenerator::Sitemap.create do
  # Statische Seiten
  add "/", changefreq: "daily", priority: 1.0
  add "/datenschutz", changefreq: "yearly"
  add "/impressum", changefreq: "yearly"
  add "/werbung-schalten", changefreq: "weekly"
  add "/hilfreiche-links", changefreq: "monthly"

  # Blogs
  BlogPost.online.find_each do |blog_post|
    add "/office-blogs/#{blog_post.to_param}", lastmod: blog_post.updated_at, changefreq: "weekly"
  end

  # Angebote
  Offer.online.find_each do |offer|
    add "/angebot/#{offer.slug}", lastmod: offer.updated_at, changefreq: "weekly"
  end

  # User
  User.online.find_each do |user|
    add "/ihr-partner/#{user.to_param}", lastmod: user.updated_at, changefreq: "weekly"
  end
end
