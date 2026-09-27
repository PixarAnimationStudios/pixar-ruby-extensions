# Copyright 2025 Pixar
#
#    Licensed under the terms set forth in the LICENSE.txt file available at
#    at the root of this project.

# frozen_string_literal: true

module PixarRubyExtensions

  module TimeExtensions

    module Utils

      # @return [Integer] the milliseconds of the Time
      def pix_msec
        strftime('%L').to_i
      end

      # This is useful for anyone who interacts with the Jamf Pro APIs, which
      # often deliver timestamps as the unix epoch in milliseconds.
      # e.g. '2023-02-28 14:43:41.456 -0800' would be 1677624221456
      #
      # @return [Integer] The Time as a unix epoch with milliseconds appended
      def pix_to_epoch_with_msecs
        msec = strftime('%L').rjust(3, '0')
        epoch = strftime('%s')
        "#{epoch}#{msec}".to_i
      end

      # @return [String] the Time formatted for our logs and UI display.
      #   '%F %T' is short for '%Y-%m-%d %H:%M:%S'
      def pix_to_display
        strftime '%F %T'
      end

      # @return [String] the Time formatted as iso8601 with the
      #   milliseconds
      def pix_to_iso8601_with_msecs
        strftime("%FT%T.#{pix_msec}%z")
      end

      # @param full_dayname [Boolean] The day name is the full version (strftime %A)
      #   instead of the default 3-letter short version (strftime %a)
      # @return [String] The English ordinal weekday of the month:
      #   Time.now.ordinal_weekday   => "2nd Wed"
      #
      def pix_ordinal_weekday(full_dayname: false)
        require 'pixar_ruby_extensions/integer'
        weeknum = (((day - 1) / 7) + 1)
        dayname_format = full_dayname ? '%A' : '%a'
        "#{weeknum.pix_ordinalize} #{strftime dayname_format}"
      end

    end # Module Utils

  end # Module

end # Module
