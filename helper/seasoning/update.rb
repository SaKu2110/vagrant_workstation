case node[:platform]
when 'ubuntu' then
    execute 'apt update'
end