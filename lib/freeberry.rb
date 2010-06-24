# encoding: utf-8
module Freeberry
  autoload :SystemSettings, 'freeberry/system_settings'
  autoload :MysqlUtils,     'freeberry/mysql_utils'
  autoload :Settingslogic,  'freeberry/settingslogic'
  autoload :HeaderTools,    'freeberry/header_tools'
  
  # Controlelrs
  autoload :AuthorizedSystem, 'freeberry/controllers/authorized_system'
  autoload :HeadOptions,      'freeberry/controllers/head_options'
  autoload :HelperTools,      'freeberry/controllers/helper_tools'
  
  # Models
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

require 'freeberry/railtie' if defined?(Rails)
