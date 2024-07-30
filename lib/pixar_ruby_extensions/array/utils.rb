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

  module ArrayExtensions

    # Useful monkey patches for Array
    module Utils

      # Fetch a string from an Array case-insensitively,
      # e.g. if my_array contains 'thrasher',
      #    my_array.pix_ci_fetch('ThRashEr')
      # will return 'thrasher'
      #
      # It only considers elements that are Strings
      # (well, that respond to .casecmp?)
      #
      # returns nil if no match
      #
      # @param somestring [String] the String to search for
      #
      # @return [String, nil] The matching string as it exists in the Array,
      #   nil if it doesn't exist
      #
      def pix_ci_fetch(somestring)
        each { |s| return s if s.respond_to?(:casecmp?) && s.casecmp?(somestring) }
        nil
      end

      # Array.pix_string_split
      # Splits string elements of an Array on a given delimiter.
      # Preserves order relative to the position in the original Array.
      #
      # @param [String] Split delimeter
      # @return [Array]
      #
      def pix_string_split!(delim)
        map! { |s| s.is_a?(String) ? s.split(delim) : s }
        flatten!
      end # end pix_string_split

      # These handy padding methods from
      # https://stackoverflow.com/questions/5608918/pad-an-array-to-be-a-certain-size
      #
      # The [l|r]just method names mirror those in String
      # The aliases are a little more Englishy
      def pix_rjust!(to_len, val)
        insert(0, *Array.new([0, to_len - length].max, val))
      end
      alias pix_padleft! pix_rjust!

      def pix_ljust!(to_len, val)
        fill(val, length...to_len)
      end
      alias pix_padright! pix_ljust!

      def pix_rjust(to_len, val)
        Array.new([0, to_len - length].max, val) + self
      end
      alias pix_padleft pix_rjust

      def pix_ljust(to_len, val)
        dup.fill(val, length...to_len)
      end
      alias pix_padright pix_ljust

    end # module

  end # module

end # module
