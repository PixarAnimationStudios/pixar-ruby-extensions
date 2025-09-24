# Copyright 2025 Pixar
#
#    Licensed under the terms set forth in the LICENSE.txt file available at
#    at the root of this project.

# frozen_string_literal: true

require 'pathname'
require 'pixar_ruby_extensions/pathname/utils'
require 'pixar_ruby_extensions/pathname/predicates'

# include the modules loaded above
class Pathname

  include PixarRubyExtensions::PathnameExtensions::Predicates
  include PixarRubyExtensions::PathnameExtensions::Utils

end
