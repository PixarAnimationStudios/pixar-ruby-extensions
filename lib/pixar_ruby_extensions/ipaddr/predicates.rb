# Copyright 2025 Pixar
#
#    Licensed under the terms set forth in the LICENSE.txt file available at
#    at the root of this project.

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
