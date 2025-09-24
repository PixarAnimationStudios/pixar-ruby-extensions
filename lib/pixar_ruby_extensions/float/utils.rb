# Copyright 2025 Pixar
#
#    Licensed under the terms set forth in the LICENSE.txt file available at
#    at the root of this project.

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
