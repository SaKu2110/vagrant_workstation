# Simplify path specification for cookbook.
def include_cookbook(cookbook)
    include_recipe "#{ENV['RECIPEPATH']}/cookbooks/#{cookbook}"
end

def include_role(role)
    include_recipe "#{ENV['RECIPEPATH']}/roles/#{role}.rb"
end

def update
    include_recipe "#{ENV['RECIPEPATH']}/helper/seasoning/update.rb"
end