# frozen_string_literal: true

require "vitepress/rails/tasks"

if Rails.root.join(".gitignore").exist?
  # High voltage generated files
  append_to_file(".gitignore", %(\n/app/views/pages/*\n!app/views/pages/.keep\n))
  # Vitepress generated files
  append_to_file(".gitignore", %(\ndocs/.vitepress/dist\ndocs/.vitepress/cache\n))
  # Public assets for rails
  append_to_file(".gitignore", %(\npublic/assets\n))
end

unless Rails.root.join("package.json").exist?
  say "Add default package.json"
  copy_file "#{__dir__}/package.json", "package.json"
end

tool = Vitepress::Rails::Tasks.tool
say "Detected package manager: #{tool}"

say "Install vitepress"
run Vitepress::Rails::Tasks.add_package_command("vitepress")

say "Add build scripts"
dev_script = "vitepress dev docs"
build_script = "vitepress build docs"

case tool
when :npm
  if %x(npx -v).to_f >= 8.0
    run %(npm pkg set scripts.docs:dev="#{dev_script}")
    run %(npm pkg set scripts.docs:build="#{build_script}")
  else
    say %(Add "scripts": { "docs:dev": "#{dev_script}", "docs:build": "#{build_script}" } to your package.json), :green
  end
when :bun, :yarn
  run %(#{tool} set-script docs:dev "#{dev_script}")
  run %(#{tool} set-script docs:build "#{build_script}")
when :pnpm
  # pnpm doesn't have set-script, need to edit package.json directly
  run %(npm pkg set scripts.docs:dev="#{dev_script}")
  run %(npm pkg set scripts.docs:build="#{build_script}")
end

say "Default vitepress config"
copy_file "#{__dir__}/config.js", "docs/.vitepress/config.js"
copy_file "#{__dir__}/index.md", "docs/index.md"

say "Vitepress installed successfully!", :green
say "Run '#{Vitepress::Rails::Tasks.dev_command}' to start the dev server"
