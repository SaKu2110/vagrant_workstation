node.reverse_merge!({
    'go': {
        'version': '1.12.5'
    }
})

golang="go#{node[:go][:version]}.linux-amd64.tar.gz"

# make go directory
# GOPATH="/home/vagrant/go"
directory "#{node[:user][:vagrant][:directory]}/go" do
    owner node[:user][:vagrant][:name]
    group node[:user][:vagrant][:name]
    not_if "ls #{node[:user][:vagrant][:directory]}/go"
end

# get golang file
# path to golang is `/usr/local/bin`
execute "curl -LO https://dl.google.com/go/#{golang}" do
    cwd '/tmp'
    not_if 'ls /usr/local/go'
end
execute "tar -C /usr/local -xzf #{golang}" do
    cwd '/tmp'
    not_if 'ls /usr/local/go'
end

# TODO: export path
# golang /usr/local/bin
# gopath /home/vagrant/go
execute "echo 'export GOPATH=$HOME/go' >> #{node[:user][:vagrant][:directory]}/.bashrc"
execute "echo 'export PATH=$PATH:$GOPATH/bin:/usr/local/go/bin' >> #{node[:user][:vagrant][:directory]}/.bashrc"