namespace :fetch_github do
  desc 'Get github content for static pages'
  task :content_for_static_pages => :environment do
    GithubStaticPagesJob.run
  end

  desc 'Load README files for AV projects using associated GitHub repository.'
  task :readme_files => :environment do
    projects = Project.with_github_url
    GithubReadmeFilesJob.run(projects)
  end
end