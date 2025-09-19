# Copyright 2025 Pixar
#
#    Licensed under the terms set forth in the LICENSE.txt file available at
#    at the root of this project.

# frozen_string_literal: true

require 'pixar_ruby_extensions/string/conversions'
require 'pixar_ruby_extensions/string/predicates'

# include the modules loaded above
class String

  include PixarRubyExtensions::StringExtensions::Predicates
  include PixarRubyExtensions::StringExtensions::Conversions

end
