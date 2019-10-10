execute 'get docker-compose binary' do
    command 'curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose'
end

execute 'chmod +x /usr/local/bin/docker-compose'