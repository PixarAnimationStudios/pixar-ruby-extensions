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

# frozen_string_literal: true

module PixarRubyExtensions

  module IPAddrExtensions

    module Predicates

      # Handy when you don't know if a value is a String or an IPAddr
      #
      # Does not start with pix_ so that you can call it on
      # either a String or an IPAddr
      #
      # Because it doesn't start with pix_ we are only
      # adding this if it doesn't already exist as an
      # instance method
      unless IPAddr.instance_methods.include? :start_with?

        def start_with?(str)
          to_s.start_with? str
        end

      end

      # Handy when you don't know if a value is a String or an IPAddr
      #
      # Does not start with pix_ so that you can call it on
      # either a String or an IPAddr
      #
      # Because it doesn't start with pix_ we are only
      # adding this if it doesn't already exist as an
      # instance method
      unless IPAddr.instance_methods.include? :end_with?

        def end_with?(str)
          to_s.end_with? str
        end

      end

    end # module

  end # module

end # module
