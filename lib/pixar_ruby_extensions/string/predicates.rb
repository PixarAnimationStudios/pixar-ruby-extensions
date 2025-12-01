# Copyright 2025 Pixar
#
#    Licensed under the terms set forth in the LICENSE.txt file available at
#    at the root of this project.

# frozen_string_literal: true

module PixarRubyExtensions

  module StringExtensions

    module Predicates

      INTEGER_RE = /\A-?[0-9]+\Z/.freeze
      FLOAT_RE = /\A-?[0-9]+\.[0-9]+\Z/.freeze

      DELIM_PLACEHOLDER = '_DELIM_'
      UUID_RE_STR = "\\A[a-f0-9]{8}#{DELIM_PLACEHOLDER}([a-f0-9]{4}#{DELIM_PLACEHOLDER}){3}[a-f0-9]{12}\\z"

      # Does this string contain an integer?
      # (i.e. it consists only of numeric digits,
      #  maybe with a dash in front)
      #
      # @return [Boolean]
      #
      def pix_integer?
        INTEGER_RE.match? self
      end

      # Does this string contain a simple float?
      # (i.e. it consists only of numeric digits,
      #  maybe with a dash in front followed by one
      #  dot, followed by at least one more digit)
      #
      # @return [Boolean]
      #
      def pix_float?
        FLOAT_RE.match? self
      end

      # is this some representation of a number?
      #
      # @return [Boolean]
      #
      def pix_numeric?
        true if Float(self)
      rescue
        false
      end

      # Is this string a UUID?
      #
      # Looks for the standard hyphenated form: 32 hexadecimal characters (0-9, a-f)
      # and four hyphen delimiters in this pattern: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
      #
      # You can specify a different delimiter if needed.
      #
      # @param delimiter [String] the delimiter used in the UUID, default '-'
      #
      # @return [Boolean]
      #
      def pix_uuid?(delimiter = '-')
        re_str = UUID_RE_STR.gsub DELIM_PLACEHOLDER, Regexp.escape(delimiter)
        regex = Regexp.new re_str, 'i'
        regex.match? self
      end

    end # module

  end # module

end # module
