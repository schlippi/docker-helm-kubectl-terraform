#!/usr/bin/env ruby
# Build and deploy script

def run(cmd)
  success = system(cmd)
  abort('Could not execute command') unless success
end

def login
  # Login to docker
  run("echo #{ENV['DOCKER_PASSWORD']} | " \
    "docker login -u #{ENV['DOCKER_USERNAME']} --password-stdin")
end

def logout
  # Logout from Docker
  run('docker logout')
end

def build_one(dir, version)
  puts "Building version #{version}"
  tag = "#{version[:helm]}__" \
    "#{version[:kubectl]}__" \
    "#{version[:terraform]}".delete('v')

  build_args = "--build-arg HELM_VERSION=#{version[:helm]} " \
               "--build-arg KUBECTL_VERSION=#{version[:kubectl]} " \
               "--build-arg TERRAFORM_VERSION=#{version[:terraform]}"
  image_name = "#{dir}:#{tag}"
  run("docker build #{build_args} -t #{image_name} .")
end

def build(dirs, versions)
  dirs.each do |dir|
    Dir.chdir(dir) do
      versions.each do |version|
        build_one(dir, version)
      end
    end
  end
end

def markdown(dirs, versions)
  dirs.each do |dir|
    Dir.chdir(dir) do
      puts ''
      puts "### #{dir}"
      puts ''
      puts '| Name | helm | kubectl | terraform |'
      puts '|------|------|---------|-----------|'

      versions.each do |version|
        tag = "#{version[:helm]}__" \
          "#{version[:kubectl]}__" \
          "#{version[:terraform]}".delete('v')
        image_name = "#{dir}:#{tag}"
        puts "| #{image_name} | #{version[:helm]} | #{version[:kubectl]} | " \
          "#{version[:terraform]} |"
      end
    end
  end
end

def tag_and_push(dir, local_tag, remote_tag)
  image_name = "#{dir}:#{local_tag}"
  public_image_name = "#{ENV['DOCKER_USERNAME']}/#{dir}:#{remote_tag}"
  run("docker tag #{image_name} #{public_image_name}")
  run("docker push #{public_image_name}")
end

def deploy_one_kubectl_latest(dir, local_tag, version, helm_versions)
  remote_tag = version[:helm].delete('v')
  tag_and_push(dir, local_tag, remote_tag)

  tag_and_push(dir, local_tag, 'latest') if version[:helm] == helm_versions.last
end

def deploy_one_terraform_latest(dir, local_tag, version, helm_versions, kubectl_versions)
  remote_tag = "#{version[:helm]}__#{version[:kubectl]}".delete('v')
  tag_and_push(dir, local_tag, remote_tag)

  deploy_one_kubectl_latest(dir, local_tag, version, helm_versions) \
    if version[:kubectl] == kubectl_versions.last
end

def deploy_one(dir, version, helm_versions, kubectl_versions, terraform_versions)
  puts "Deploying version #{version}"
  local_tag = "#{version[:helm]}__#{version[:kubectl]}__" \
    "#{version[:terraform]}".delete('v')
  tag_and_push(dir, local_tag, local_tag)

  return unless version[:terraform] == terraform_versions.last
  deploy_one_terraform_latest(
    dir, local_tag, version, helm_versions,
    kubectl_versions
  )
end

def deploy(dirs, versions, helm_versions, kubectl_versions, terraform_versions)
  dirs.each do |dir|
    versions.each do |version|
      deploy_one(
        dir, version, helm_versions,
        kubectl_versions, terraform_versions
      )
    end
  end
end

helm_versions = ['v2.8.2', 'v2.11.0']
kubectl_versions = ['v1.11.3', 'v1.12.0']
terraform_versions = ['0.11.11']

versions = []

helm_versions.each do |h|
  kubectl_versions.each do |k|
    terraform_versions.each do |t|
      versions.push(helm: h, kubectl: k, terraform: t)
    end
  end
end

# find all top level folders, except hidden
dirs = Dir.glob('*').select { |f| File.directory? f }

if ARGV[0] == 'deploy'
  login
  deploy(dirs, versions, helm_versions, kubectl_versions, terraform_versions)
  logout
elsif ARGV[0] == 'markdown'
  markdown(dirs, versions)
else
  build(dirs, versions)
end
