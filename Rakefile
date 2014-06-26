# Setup Bundler
require 'rubygems'
require 'bundler/setup'

# Rsync configuration
ssh_user       = "user@domain.com"
ssh_port       = "22"
document_root  = "~/website.com/"
rsync_delete   = true
rsync_args     = ""               # Any extra arguments to pass to rsync

# GitHub pages configuration
github_user = "username"
github_project = ""               # Leave this variable empty if you're using user or organization pages
deploy_branch = "master"          # For project pages, replace it with "gh-pages"

# Misc
source_dir = "."
public_dir = "./_site"
deploy_dir = "./_deploy"          # Deployment directory for GitHub Pages
posts_dir = "./_posts"
post_ext = "markdown"


#
# Overview
#
desc "List tasks"
task :list do
  puts "Tasks: #{(Rake::Task.tasks - [Rake::Task[:list]]).join(', ')}"
  puts "(type rake -T for more detail)\n\n"
end


#
# Posts
#
desc "Create a post"
task :create_post, :title do |t, args|
  if args.title
    title = args.title
  else
    title = get_stdin("Enter a title for your post: ")
  end

  mkdir_p "#{source_dir}/#{posts_dir}"
  filename = "#{source_dir}/#{posts_dir}/#{Time.now.strftime('%Y-%m-%d')}-#{slugify(title)}.#{post_ext}"
  if File.exist?(filename)
    abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
  end

  puts "Creating new post: #{filename}"
  open(filename, 'w') do |post|
    post.puts "---"
    post.puts "layout: post"
    post.puts "title: \"#{title.gsub(/&/,'&amp;')}\""
    post.puts "description:"
    post.puts "date: #{Time.now.strftime('%Y-%m-%d %H:%M:%S %z')}"
    post.puts "comments: true"
    post.puts "categories:"
    post.puts "cover_image:"
    post.puts "tags:"
    post.puts "---"
  end
end


#
# Build and preview site
#
desc "Cleanup cache files"
task :clean do
  system "rm -rf #{public_dir}"
end

desc "Build jekyll site"
task :build do
  puts "Building site with Jekyll..."
  system "jekyll build"
end

desc "Preview jekyll site"
task :preview do
  puts "Build and preview site..."
  system "jekyll serve --watch"
end


#
# Deploy
#
namespace :deploy do
  desc "Deploy jekyll site via rsync"
  task :rsync => :build do
    exclude = ""
    if File.exists?('./rsync-exclude')
      exclude = "--exclude-from '#{File.expand_path('./rsync-exclude')}'"
    end
    puts "Deploying website via Rsync..."
    ok_failed system("rsync -avze 'ssh -p #{ssh_port}' #{exclude} #{rsync_args} #{"--delete" unless rsync_delete == false} #{public_dir}/ #{ssh_user}:#{document_root}")
  end

  desc "Deploy GitHub pages"
  task :github, [:message] => [:build] do |t, args|
    if args.message
      message = args.message
    else
      message = "Site updated at #{Time.now.utc}"
    end

    puts "## Deploying branch to Github Pages "
    puts "## Pulling any updates from Github Pages "
    cd "#{deploy_dir}" do
      system "git checkout #{deploy_branch}"
      system "git pull origin #{deploy_branch}"
    end

    puts "\n## Copying #{public_dir} to #{deploy_dir}"
    cp_r "#{public_dir}/.", deploy_dir

    cd "#{deploy_dir}" do
      system "git add -A"
      puts "\n## Committing: #{message}"
      system "git commit -m \"#{message}\""
      puts "\n## Pushing generated #{deploy_dir} website"
      system "git push origin #{deploy_branch}"
      puts "\n## Github Pages deploy complete"
    end
  end
end


desc "Setup deploy directory and branch for Github Pages deployment"
task :setup_github_pages do
  rm_rf deploy_dir
  mkdir deploy_dir
  cd "#{deploy_dir}" do
    system "git init"
    system "echo 'Hello, GitHub Pages.' > index.html"
    system "git add ."
    system "git commit -m \"Initial commit\""
    system "git branch -m #{deploy_branch}"
    system "git remote add origin #{repo_url github_user, github_project}"
  end
  puts "\n---\n## Now you can deploy to #{repo_url github_user, github_project} with `rake deploy:github` ##"
end


#
# Helper methods
#
def ok_failed(condition)
  if (condition)
    puts "OK"
  else
    puts "FAILED"
  end
end

def get_stdin(message)
  print message
  STDIN.gets.chomp
end

def ask(message, valid_options)
  if valid_options
    answer = get_stdin("#{message} #{valid_options.to_s.gsub(/"/, '').gsub(/, /,'/')} ") while !valid_options.include?(answer)
  else
    answer = get_stdin(message)
  end
  answer
end

def slugify(str)
  str.downcase.gsub(/[^a-z0-9]+/, '-').gsub(/^-|-$/, '');
end

def site_url(user)
  if File.exists?('source/CNAME')
    "http://#{IO.read('source/CNAME').strip}"
  else
    "http://#{user}.github.io"
  end
end

def repo_url(user, project)
  if project == ''
    "https://github.com/#{user}/#{user}.github.io.git"
  else
    "https://github.com/#{user}/#{project}.git"
  end
end
