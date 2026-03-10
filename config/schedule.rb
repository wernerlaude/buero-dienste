set :output, "log/cron.log"  # optional: Logfile

every 1.day, at: "3:00 am" do
  rake "sitemap:refresh"  # rake statt runner!
end
