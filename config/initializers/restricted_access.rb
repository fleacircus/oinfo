require 'restricted_access/controller'
require 'restricted_access/model_additions'

ActiveRecord::Base.extend RestrictedAccess::ModelAdditions
