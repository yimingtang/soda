# Setup Bundler
require 'rubygems'
require 'bundler/setup'

# Rsync configuration
ssh_user       = "user@domain.com"
ssh_port       = "22"
document_root  = "~/website.com/"
rsync_delete   = false
rsync_args     = ""                 # Any extra arguments to pass to rsync
deploy_default = "rsync"

# Misc
source_dir = "."
public_dir = "./_site"
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
  filename = "#{source_dir}/#{posts_dir}/#{Time.now.strftime('%Y-%m-%d')}-#{title}.#{post_ext}"
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
desc "Deploy jekyll site via rsync"
task :deploy => :build do
  exclude = ""
  if File.exists?('./rsync-exclude')
    exclude = "--exclude-from '#{File.expand_path('./rsync-exclude')}'"
  end
  puts "Deploying website via Rsync..."
  ok_failed system("rsync -avze 'ssh -p #{ssh_port}' #{exclude} #{rsync_args} #{"--delete" unless rsync_delete == false} #{public_dir}/ #{ssh_user}:#{document_root}")
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
