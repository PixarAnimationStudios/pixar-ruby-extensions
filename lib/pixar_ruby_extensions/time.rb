# Copyright 2025 Pixar
#
#    Licensed under the terms set forth in the LICENSE.txt file available at
#    at the root of this project.

# frozen_string_literal: true

require 'time'
require 'pixar_ruby_extensions/time/utils'

# include the modules loaded above
class Time

  include PixarRubyExtensions::TimeExtensions::Utils

end
