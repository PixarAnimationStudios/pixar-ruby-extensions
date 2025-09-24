# Copyright 2025 Pixar
#
#    Licensed under the terms set forth in the LICENSE.txt file available at
#    at the root of this project.

# frozen_string_literal: true

require 'pixar_ruby_extensions/array/predicates'
require 'pixar_ruby_extensions/array/utils'

# an array
class Array

  include PixarRubyExtensions::ArrayExtensions::Predicates
  include PixarRubyExtensions::ArrayExtensions::Utils

end # class
