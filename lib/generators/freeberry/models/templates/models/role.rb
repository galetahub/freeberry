# == Schema Information
#
# Table name: roles
#
#  id         :integer(4)      not null, primary key
#  kind       :integer(1)      default(0)
#  user_id    :integer(4)      not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_roles_on_user_id  (user_id)
#

class Role < ActiveRecord::Base
  include Freeberry::Role
end
