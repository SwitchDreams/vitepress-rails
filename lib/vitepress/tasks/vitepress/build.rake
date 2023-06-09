# frozen_string_literal: true

DEFAULT_BASE_PATH = "docs/"
DOCS_PUBLIC_FOLDER_PATH = "../public/#{DEFAULT_BASE_PATH}"

namespace :vitepress do
  desc "Build your docs"
  task build: :environment do
    Dir.chdir("./docs") do
      unless system "yarn install && yarn docs:build"
        raise "vitepress: docs:build failed"
      end

      # Move html files to pages folder
      Dir.glob(".vitepress/dist/**/*.html").each do |file|
        dir = File.dirname(file)
        filename = File.basename(file)

        dest = File.join("../app/views/pages", dir.remove(".vitepress/dist"))
        FileUtils.mkdir_p(dest)

        FileUtils.copy_file(file, File.join(dest, filename))
      end

      # Create docs public folder
      Dir.mkdir(DOCS_PUBLIC_FOLDER_PATH) unless Dir.exist?(DOCS_PUBLIC_FOLDER_PATH)

      # Move assets files to public
      if Dir.exist?(".vitepress/dist/assets")
        FileUtils.copy_entry(".vitepress/dist/assets", "#{DOCS_PUBLIC_FOLDER_PATH}assets")
      end

      # Copy public files
      if Dir.exist?("public")
        FileUtils.copy_entry("public", DOCS_PUBLIC_FOLDER_PATH)
      end
    end
  end
end

if Rake::Task.task_defined?("assets:precompile")
  Rake::Task["assets:precompile"].enhance(["vitepress:build"])
end
