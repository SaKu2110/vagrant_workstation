execute 'get docker-machine binary' do
    command 'curl -L https://github.com/docker/machine/releases/download/v0.7.0/docker-machine-`uname -s`-`uname -m` > /usr/local/bin/docker-machine'
end
execute 'chmod +x /usr/local/bin/docker-machine'