# frozen_string_literal: true

namespace :vitepress do
  desc "Install vitepress"
  task install: :environment do
    system "#{RbConfig.ruby} ./bin/rails app:template LOCATION=#{File.expand_path("./init/install.rb", __dir__)}"
  end
end
