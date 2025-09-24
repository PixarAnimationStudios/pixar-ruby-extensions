# Copyright 2025 Pixar
#
#    Licensed under the terms set forth in the LICENSE.txt file available at
#    at the root of this project.

# frozen_string_literal: true

require 'pixar_ruby_extensions/object/predicates'

# include the modules loaded above
class Object

  include PixarRubyExtensions::ObjectExtensions::Predicates

end
