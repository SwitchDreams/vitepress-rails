# frozen_string_literal: true

module Vitepress
  module Rails
    module Tasks
      extend self

      def install_command
        case tool
        when :bun then "bun install"
        when :yarn then "yarn install"
        when :pnpm then "pnpm install"
        when :npm then "npm install"
        else raise "vitepress-rails: No suitable tool found for installing JavaScript dependencies"
        end
      end

      def dev_command
        case tool
        when :bun then "bun run docs:dev"
        when :yarn then "yarn docs:dev"
        when :pnpm then "pnpm docs:dev"
        when :npm then "npm run docs:dev"
        else raise "vitepress-rails: No suitable tool found for dev command"
        end
      end

      def build_command
        case tool
        when :bun then "bun run docs:build"
        when :yarn then "yarn docs:build"
        when :pnpm then "pnpm docs:build"
        when :npm then "npm run docs:build"
        else raise "vitepress-rails: No suitable tool found for building JavaScript"
        end
      end

      def add_package_command(package)
        case tool
        when :bun then "bun add -D #{package}"
        when :yarn then "yarn add -D #{package}"
        when :pnpm then "pnpm add -D #{package}"
        when :npm then "npm install -D #{package}"
        else raise "vitepress-rails: No suitable tool found for adding packages"
        end
      end

      def tool
        tool_determined_by_lock_file || tool_determined_by_executable
      end

      def tool_determined_by_lock_file
        if File.exist?("bun.lockb")
          :bun
        elsif File.exist?("bun.lock")
          :bun
        elsif File.exist?("yarn.lock")
          :yarn
        elsif File.exist?("pnpm-lock.yaml")
          :pnpm
        elsif File.exist?("package-lock.json")
          :npm
        end
      end

      def tool_determined_by_executable
        [:bun, :yarn, :pnpm, :npm].each do |exe|
          return exe if system "command -v #{exe} > /dev/null"
        end
      end
    end
  end
end
