node.reverse_merge!({
    'kubernetes': {
        'version': '1.11.1'
    }
})
node.reverse_merge!({
    'kubernetes': {
        'binary': 'kubernetes-server-linux-amd64',
        'package': 'kubernetes-server-linux-amd64.tar.gz',
        'URL': "https://dl.k8s.io/v#{node[:kubernetes][:version]}/kubernetes-server-linux-amd64.tar.gz",
        'master': {
            'config': [
                'apiserver',
                'controller-manager',
                'scheduler',
                'proxy',
                'kubelet'
            ],
            'unit': [
                'kube-apiserver',
                'kube-controller-manager',
                'kube-scheduler',
                'kube-proxy',
                'kubelet'
            ]
        },
        'nodes': {
            'config': [
                'proxy',
                'kubelet'
            ],
            'unit': [
                'kube-proxy',
                'kubelet'
            ]
        }
    }
})

execute 'Get kube binary package files' do
    command "curl -LO #{node[:kubernetes][:URL]}"
    cwd '/tmp'
    not_if "ls /tmp/#{node[:kubernetes][:package]}"
end

execute 'Thawing binary package file' do
    command "tar xf #{node[:kubernetes][:package]}"
    cwd '/tmp'
end