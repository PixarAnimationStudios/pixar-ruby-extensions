# Copyright 2025 Pixar
#
#    Licensed under the terms set forth in the LICENSE.txt file available at
#    at the root of this project.

# frozen_string_literal: true

module PixarRubyExtensions

  module ObjectExtensions

    module Predicates

      BOOLEANS = [true, false].freeze

      # is an object an explict true or false?
      #
      # @return [Boolean]
      #
      def pix_boolean?
        BOOLEANS.include? self
      end
      alias pix_bool? pix_boolean?

      # Is an object nil, or empty?
      #
      # Handier, and broader, than constantly doing
      # var.to_s.empty? and doesn't require coercion
      #
      # @return [Boolean]
      #
      def pix_empty?
        if nil?
          true
        elsif respond_to?(:empty?)
          empty?
        else
          false
        end
      end

      # pix_empty? was originally pix_blank?
      alias pix_blank? pix_empty?

    end # module

  end # module

end # module
