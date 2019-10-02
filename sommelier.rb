# Apply cookbook according to the assigned role
# Load helper used for itamae
require_relative 'helper/helper.rb'

# Default role is `base`
include_role 'base'

=begin
# Apply role recipe
case node[:role]
when '' then
end
=end