# Install Dependent package
package 'apt-transport-https'
package 'ca-certificates'
package 'software-properties-common'

case node[:platform]
when 'ubuntu' then
    # Get gpg key
    execute 'curl -fsSL https://download.docker.com/linux/ubuntu/gpg >> docker_gpg' do
        cwd '/tmp'
        not_if 'ls /tmp/docker_gpg'
    end
    # TODO: 冪等性を担保できるようにする
    # Add docker apt key
    execute 'apt-key add /tmp/docker_gpg' do
        cwd '/tmp'
    end
    execute 'add docker repository' do
        command 'add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable edge"'
    end
else
    # TODO: OTHER DISTORIBUTION
end

# Apt package update
update()

# Install Docker
package 'docker-ce'

# Apply user permision as `Docker`
execute "usermod -g docker #{node[:user][:vagrant][:name]}"

# Docker restert
service 'docker' do
    action [:restart, :enable]
end