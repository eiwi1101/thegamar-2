require 'rubygems'
require 'active_support/all'
require 'bundler/setup'
Bundler.require


require_relative 'lib/dsl_base'
require_relative 'lib/game_error'

require_all 'lib'

if $WORLD_GAME_PATH
  require_all $WORLD_GAME_PATH
else
  require_all 'game'
end
