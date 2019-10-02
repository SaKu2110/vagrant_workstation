if node[:nginx] then
    package 'nginx' do
        version node[:nginx]
    end
else
    package 'nginx'
end