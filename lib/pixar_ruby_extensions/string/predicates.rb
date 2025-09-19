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

      # Does this string contain an integer?
      # (i.e. it consists only of numeric digits,
      #  maybe with a dash in front)
      #
      # @return [Boolean]
      #
      def pix_integer?
        self =~ INTEGER_RE ? true : false
      end

      # Does this string contain a float?
      # (i.e. it consists only of numeric digits,
      #  maybe with a dash in front followed by one
      #  dot, followed by at least one more digit)
      #
      # @return [Boolean]
      #
      def pix_float?
        self =~ FLOAT_RE ? true : false
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

    end # module

  end # module

end # module
