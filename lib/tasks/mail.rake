namespace :mail do
  desc "Remove all files from tmp/sent_mails"
  task :clear do
    FileList["tmp/sent_mails/*"].each do |mail_file|
      File.delete(mail_file)
    end
  end
end
