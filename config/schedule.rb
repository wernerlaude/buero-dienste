set :environment, "production"
set :output, "/home/buero/log/cron.log"

every 1.day, at: "3:00 am" do
  command "cd /home/buero && RAILS_ENV=production bundle exec rails sitemap:create --silent"
end
