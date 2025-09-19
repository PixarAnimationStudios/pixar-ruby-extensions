# Copyright 2025 Pixar
#
#    Licensed under the terms set forth in the LICENSE.txt file available at
#    at the root of this project.

# frozen_string_literal: true

require 'pixar_ruby_extensions/hash/utils'

# include the modules loaded above
class Hash

  include PixarRubyExtensions::HashExtensions::Utils

end
