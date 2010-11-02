# == Schema Information
#
# Table name: assets
#
#  id                :integer(4)      not null, primary key
#  data_file_name    :string(255)     not null
#  data_content_type :string(255)
#  data_file_size    :integer(4)
#  assetable_id      :integer(4)      not null
#  assetable_type    :string(25)      not null
#  type              :string(25)
#  guid              :string(10)
#  locale            :integer(1)      default(0)
#  user_id           :integer(4)
#  created_at        :datetime
#  updated_at        :datetime
#
# Indexes
#
#  index_assets_on_assetable_type_and_type_and_assetable_id  (assetable_type,type,assetable_id)
#  index_assets_on_assetable_type_and_assetable_id           (assetable_type,assetable_id)
#  index_assets_on_user_id                                   (user_id)
#

class Picture < Asset
  has_attached_file :data,
                    :url  => "/assets/pictures/:id/:style_:basename.:extension",
                    :path => ":rails_root/public/assets/pictures/:id/:style_:basename.:extension",
                    :convert_options => { :all => "-strip" },
	                  :styles => { :content => '575>', :thumb => '80x80#', :cover => '400x250#' }
	
	validates_attachment_size :data, :less_than => 2.megabytes
	
	attr_accessible :data
end
