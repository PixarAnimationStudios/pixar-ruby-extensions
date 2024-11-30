# Copyright 2022 Pixar
#
#    Licensed under the Apache License, Version 2.0 (the "Apache License")
#    with the following modification; you may not use this file except in
#    compliance with the Apache License and the following modification to it:
#    Section 6. Trademarks. is deleted and replaced with:
#
#    6. Trademarks. This License does not grant permission to use the trade
#       names, trademarks, service marks, or product names of the Licensor
#       and its affiliates, except as required to comply with Section 4(c) of
#       the License and to reproduce the content of the NOTICE file.
#
#    You may obtain a copy of the Apache License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the Apache License with the above modification is
#    distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
#    KIND, either express or implied. See the Apache License for the specific
#    language governing permissions and limitations under the Apache License.
#
#

# frozen_string_literal: true

# These are extensions to Ruby modules and classes in Ruby's Core
# and Standard Library. We've put them here because we've found
# ourselves performing these tasks repeatedly in our code over the years
# and we like to stay DRY.
# They are also used in our open-source projects, and their use there
# will be migrating to use this gem, rather than their built-in
# versions - also in pursuit of DRYness.

# To ease troubleshooting and prevent name collisions:

# - With only a couple of exceptions, all monkey-patched methods are
#   prefixed with "pix_"

# - Methods are not directly monkey-patched into the Core or StdLib classes/modules.
#   Instead they are defined in modules with obvious namespaces, and mixed-in to the
#   Core or StdLib classes/modules. This provides _much_ easier debugging when there
#   are exceptions, since the error and backtrace will indicate exactly where these
#   methods are defined.
module PixarRubyExtensions; end

require 'pixar_ruby_extensions/version'

# NOTE: You may require these individually if you don't need them all.

require 'pixar_ruby_extensions/array'
require 'pixar_ruby_extensions/filetest'
require 'pixar_ruby_extensions/hash'
require 'pixar_ruby_extensions/integer'
require 'pixar_ruby_extensions/float'
require 'pixar_ruby_extensions/ipaddr'
require 'pixar_ruby_extensions/json'
require 'pixar_ruby_extensions/object'
require 'pixar_ruby_extensions/pathname'
require 'pixar_ruby_extensions/string'
require 'pixar_ruby_extensions/time'
