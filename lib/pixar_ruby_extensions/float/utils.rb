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

require 'pixar_ruby_extensions/integer'

module PixarRubyExtensions

  module FloatExtensions

    module Utils

      # See IntegerExtensions::Utils.pix_humanize_secs for more info
      # Runs that method on the integer part of the float, then append the fraction
      # as a decimal part of a second.
      #
      # @return [String] The integer number of seconds, expressed in descending English time units
      #
      def pix_humanize_secs(omit_zeros: false, down_to: :seconds, up_to: :years)
        int, fraction = to_s.split('.')
        int.to_i.pix_humanize_secs(
          omit_zeros: omit_zeros,
          down_to: down_to,
          up_to: up_to,
          fraction: fraction
        )
      end

    end # module

  end # module

end # module
