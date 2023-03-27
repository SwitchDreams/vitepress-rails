# frozen_string_literal: true

if Rails.root.join(".gitignore").exist?
  # High voltage genereated files
  append_to_file(".gitignore", %(\n/app/views/pages/*\n!app/views/pages/.keep\n))
  # Vitepress generated files
  append_to_file(".gitignore", %(\n.vitepress/dist\n.vitepress/cache\n))
end

unless Rails.root.join("package.json").exist?
  say "Add default package.json"
  copy_file "#{__dir__}/package.json", "package.json"
end

say "Install vitepress"
run "yarn add -D vitepress"

say "Add build script"
dev_script = "vitepress dev docs"
build_script = "vitepress build docs"

case %x(npx -v).to_f
when 7.1...8.0
  run %(npm set-script docs:dev "#{dev_script}")
  run %(npm set-script docs:build "#{build_script}")
when (8.0..)
  run %(npm pkg set scripts.docs:dev="#{dev_script}")
  run %(npm pkg set scripts.docs:build="#{build_script}")
else
  say %(Add "scripts": { "docs:dev": "#{dev_script}" } to your package.json), :green
  say %(Add "scripts": { "docs:build": "#{build_script}" } to your package.json), :green
end

say "Default vitepress config"
copy_file "#{__dir__}/config.js", "docs/.vitepress/config.js"
copy_file "#{__dir__}/index.md", "docs/index.md"
