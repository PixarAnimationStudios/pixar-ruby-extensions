# Copyright 2025 Pixar
#
#    Licensed under the terms set forth in the LICENSE.txt file available at
#    at the root of this project.

# frozen_string_literal: true

require 'ipaddr'
require 'pixar_ruby_extensions/ipaddr/utils'
require 'pixar_ruby_extensions/ipaddr/predicates'

############################################
# A few augmentations to IPAddr handling.
#
class IPAddr

  extend PixarRubyExtensions::IPAddrExtensions::Utils
  include PixarRubyExtensions::IPAddrExtensions::Predicates

end # Class IPAddr
