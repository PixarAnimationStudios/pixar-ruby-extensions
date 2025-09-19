# Copyright 2025 Pixar
#
#    Licensed under the terms set forth in the LICENSE.txt file available at
#    at the root of this project.

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

      # Array#pix_to_jsonl
      #
      # Convert an Array of objects to a jsonlines string
      #
      # @param opts [Hash] Options to pass to JSON.dump
      #
      # @return [String] The jsonlines string
      #
      def pix_to_jsonl(**opts)
        map { |obj| JSON.generate(obj, **opts) }.join("\n")
      end

    end # module

  end # module

end # module
