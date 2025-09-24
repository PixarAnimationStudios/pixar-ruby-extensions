# Copyright 2025 Pixar
#
#    Licensed under the terms set forth in the LICENSE.txt file available at
#    at the root of this project.

# frozen_string_literal: true

require 'json'
require 'pixar_ruby_extensions/json/utils'
require 'pixar_ruby_extensions/json/jsonl'

module JSON

  extend PixarRubyExtensions::JSONExtensions::Utils
  extend PixarRubyExtensions::JSONExtensions::JSONL

end
