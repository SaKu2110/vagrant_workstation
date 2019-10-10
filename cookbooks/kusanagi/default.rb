node.reverse_merge!({
    'kusanagi': {
        'container': [
            'primestrategy/kusanagi-nginx',
            'primestrategy/kusanagi-httpd',
            'primestrategy/kusanagi-php',
            'primestrategy/kusanagi-config',
            'wordpress',
            'primestrategy/kusanagi-ftpd',
            'mariadb',
            'postgres',
            'certbot/certbot'
        ]
    }
})
include_cookbook 'docker'
include_cookbook 'docker/compose'
include_cookbook 'docker/machine'
include_cookbook 'gettext-base'
include_cookbook 'gettext'

# install kusanagi docker
execute 'get kusanagi installer' do
    command 'curl -O https://raw.githubusercontent.com/prime-strategy/kusanagi-docker/master/install.sh'
    user node[:user][:vagrant][:name]
    cwd node[:user][:vagrant][:directory]
end
execute 'bash install.sh' do
    user node[:user][:vagrant][:name]
    cwd node[:user][:vagrant][:directory]
end
execute 'mv install.sh /tmp' do
    user node[:user][:vagrant][:name]
    cwd node[:user][:vagrant][:directory]
end

# export path to kusanagi-docker
execute "echo 'export PATH=$PATH:$HOME/.kusanagi/bin' >> #{node[:user][:vagrant][:directory]}/.bashrc"

# Install latest docker images
node[:kusanagi][:container].each do |image|
    execute "docker pull #{image}"
end