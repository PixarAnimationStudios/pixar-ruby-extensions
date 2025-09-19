# Copyright 2025 Pixar
#
#    Licensed under the terms set forth in the LICENSE.txt file available at
#    at the root of this project.

# frozen_string_literal: true

module PixarRubyExtensions

  module ArrayExtensions

    module Predicates

      # A case-insensitive version of #include? for Arrays.
      # It only considers elements that are Strings
      # (well, that respond to .casecmp?)
      #
      # @param somestring [String] the String to search for
      #
      # @return [Boolean] Does the Array contain the String, ignoring case?
      #
      def pix_ci_include?(somestring)
        any? { |s| s.respond_to?(:casecmp?) && s.casecmp?(somestring) }
      end

    end # module

  end # module

end # module
