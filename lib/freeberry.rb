# encoding: utf-8
require 'freeberry/core_ext'

module Freeberry
  autoload :SystemSettings,       'freeberry/system_settings'
  autoload :MysqlUtils,           'freeberry/mysql_utils'
  autoload :Settingslogic,        'freeberry/settingslogic'
  autoload :HeaderUtils,          'freeberry/header_utils'
  autoload :ModelFilter,          'freeberry/model_filter'
  autoload :Transliteration,      'freeberry/transliteration'
  autoload :AccessibleAttributes, 'freeberry/accessible_attributes'
  autoload :Utils,                'freeberry/utils'
  
  # Controllers
  module Controllers
    autoload :HeadOptions, 'freeberry/controllers/head_options'
    autoload :HelperUtils, 'freeberry/controllers/helper_utils'
  end
  
  # Models
  module Models
    autoload :RoleType,      'freeberry/models/role_type'
    autoload :StructureType, 'freeberry/models/structure_type'
    autoload :PositionType,  'freeberry/models/position_type'
    autoload :User,          'freeberry/models/user'
    autoload :Role,          'freeberry/models/role'
    autoload :Structure,     'freeberry/models/structure'
    autoload :Page,          'freeberry/models/page'
    autoload :Post,          'freeberry/models/post'
    autoload :Comment,       'freeberry/models/comment'
    autoload :Asset,         'freeberry/models/asset'
    autoload :Header,        'freeberry/models/header'
  end
  
  IMAGE_TYPES = ['image/jpeg', 'image/png', 'image/gif', 'image/jpg', 'image/pjpeg', 'image/tiff', 'image/x-png']
end

require 'freeberry/railtie'
