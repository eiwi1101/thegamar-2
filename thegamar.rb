require 'rubygems'

require 'active_support/all'

require 'bundler/setup'
Bundler.require


require_relative 'lib/dsl_base'
require_relative 'lib/game_error'

require_all 'lib'
require_all 'game'
