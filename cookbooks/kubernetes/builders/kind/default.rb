include_cookbook 'kubernetes/installer'

node.reverse_merge!({
    'kind': {
        'version': '0.5.1'
    }
})

kindURL="https://github.com/kubernetes-sigs/kind/releases/download/v#{node[:kind][:version]}/kind-linux-amd64"

execute 'Placed kubectl file' do
    command "install kubectl /usr/bin/kubectl"
    cwd '/tmp/kubernetes/server/bin'
    not_if 'ls /usr/bin/kubectl'
end

execute 'get kind file' do
    command "curl -Lo /tmp/kind #{kindURL}"
    not_if "ls /tmp/kind"
end

execute 'Placed kind file' do
    command 'install kind /usr/local/bin'
    cwd '/tmp'
    not_if 'ls /usr/local/bin/kind'
end