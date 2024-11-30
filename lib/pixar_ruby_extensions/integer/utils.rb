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

  module IntegerExtensions

    module Utils

      # Array for processing pix_humanize_secs.
      # How many weeks in a year??
      # first, given the Gregorian calendar, how many days in 1000 years?
      #   365000 days if all are common years
      #  +250    cuz every 4th year is a leap year
      #  - 7     cuz centuries are only leap years if divisble by 400
      #            so there are only 3, not 10
      #  = 365243
      #
      #  and there are 7 days per week, so in 1000 years, a week averages to
      #  365243 / 7
      #  = 5217.7571428571426 weeks per 1000 years
      #  = 52.177571428571426 weeks per year

      HUMANIZE_SECS_ARRAY = [
        [60, :seconds, :second],
        [60, :minutes, :minute],
        [24, :hours, :hour],
        [7, :days, :day],
        [52.1776, :weeks, :week],
        [100, :years, :year],
        [10, :centuries, :century],
        [Float::INFINITY, :millenia, :millenium]
      ].freeze

      # Very handy!
      # Converts an integer number of seconds into a English string, like so:
      #
      #    123456789.humanize_secs
      #    # => "3 years 47 weeks 0 days 21 hours 33 minutes 9 seconds"
      #
      # Idea credits to:
      # Mladen Jablanović at
      # http://stackoverflow.com/questions/4136248/how-to-generate-a-human-readable-time-range-using-ruby-on-rails
      #
      # And:
      # Jonathan Simmons at
      # https://gist.github.com/jonathansimmons/24fa43ac6ee53819fb93
      #
      # @param omit_zeros [Boolean] If true, units with a value of zero, like '0 weeks' or
      #   '0 hours' will be omitted, so the output of calling this on the 123456789 example above
      #   would be "3 years 47 weeks 21 hours 33 minutes 9 seconds". Default is false
      #
      # @param down_to [Symbol]  One of :seconds, :minutes, :hours, :days, :weeks, :years,
      #   :centuries, :millenia
      #   Only include time units down-to and including this one. Default is :seconds
      #   NOTE: output is truncated not rounded. In the example here, you lose all info
      #   about the 21 hrs, 33 min, and 9 secs, and just see '0 days'
      #   @example:
      #      123456789.pix_humanize_secs
      #      # => "3 years 47 weeks 0 days 21 hours 33 minutes 9 seconds"
      #
      #      123456789.pix_humanize_secs down_to: :days
      #      # => "3 years 47 weeks 0 days"
      #
      # @param up_to [Symbol]  One of :seconds, :minutes, :hours, :days, :weeks, :years,
      #   :centuries, :millenia
      #   Only include time units up-to and including this one. Default is :years.
      #   @example:
      #      44567789123.pix_humanize_secs
      #      # => "1412 years 13 weeks 0 days 21 hours 25 minutes 23 seconds"
      #
      #      44567789123.pix_humanize_secs up_to: :millenia
      #      # => "1 millenium 4 centuries 12 years 13 weeks 0 days 21 hours 25 minutes 23 seconds"
      #
      # @return [String] The integer number of seconds, expressed in descending English time units
      #
      def pix_humanize_secs(omit_zeros: false, down_to: :seconds, up_to: :years, fraction: nil)
        # initialize values for our loop
        remaining_next_unit = self
        down_to_this_unit = false
        up_to_this_unit = false

        output_array = HUMANIZE_SECS_ARRAY.map do |count, current_unit, singular|
          unit_names = [current_unit, singular]
          # puts "START: starting next unit: #{current_unit}, remaining_next_unit: #{remaining_next_unit}"

          # stop when or integer hits zero
          next unless remaining_next_unit.positive?

          # stop if we've hit our up_to unit
          next if up_to_this_unit

          if unit_names.include?(up_to)
            up_to_this_unit = true
            current_unit_count = remaining_next_unit
          else
            remaining_next_unit, current_unit_count = remaining_next_unit.divmod(count)
          end

          # puts "MID: current_unit: #{current_unit}, current_unit_count: #{current_unit_count}, remaining_next_unit: #{remaining_next_unit}"

          # skip if we are below our down_to unit
          down_to_this_unit ||= unit_names.include?(down_to)
          next unless down_to_this_unit

          display_current_unit_count = current_unit_count.to_i
          # if we are processing 'seconds' and there is a fraction, append it to the seconds
          display_current_unit_count += "0.#{fraction}".to_f if current_unit == :seconds && fraction

          next if omit_zeros && display_current_unit_count.zero?

          display_name = display_current_unit_count <= 1 ? singular : current_unit

          "#{display_current_unit_count} #{display_name}"
        end # map

        output_array.compact.reverse.join ' '
      end

      A_BYTE = 1
      B_BYTES = 1.0
      KB_BYTES = B_BYTES * 1024
      MB_BYTES = KB_BYTES * 1024
      GB_BYTES = MB_BYTES * 1024
      TB_BYTES = GB_BYTES * 1024
      PB_BYTES = TB_BYTES * 1024

      HUMANIZED_BYTE_UNITS = {
        A_BYTE => 'byte',
        B_BYTES => 'bytes',
        KB_BYTES => 'KiB',
        MB_BYTES => 'MiB',
        GB_BYTES => 'GiB',
        TB_BYTES => 'TiB',
        PB_BYTES => 'PiB'
      }.freeze

      # A number of bytes converted into a string showing
      # KibiBytes, Mebibytes, etc up to Pebibytes, with 2
      # decimal places of precision.
      #
      # Returns a string with the unit in the form 'MiB'
      # unless < 1KiB, in which case 'byte(s)'
      # For 76253886 bytes this will return "72.72 MiB"
      #
      # @return [String] The human-readable file size.
      #######
      def pix_humanize_bytes
        bytes = self
        if bytes < KB_BYTES
          hsize = bytes
          unit =  bytes == A_BYTE ? HUMANIZED_BYTE_UNITS[A_BYTE] : HUMANIZED_BYTE_UNITS[B_BYTES]

        elsif bytes < MB_BYTES
          hsize = (bytes / KB_BYTES).round(2)
          unit = HUMANIZED_BYTE_UNITS[KB_BYTES]

        elsif bytes < GB_BYTES
          hsize = (bytes / MB_BYTES).round(2)
          unit = HUMANIZED_BYTE_UNITS[MB_BYTES]

        elsif bytes < TB_BYTES
          hsize = (bytes / GB_BYTES).round(2)
          unit = HUMANIZED_BYTE_UNITS[GB_BYTES]

        elsif bytes < PB_BYTES
          hsize = (bytes / TB_BYTES).round(2)
          unit = HUMANIZED_BYTE_UNITS[TB_BYTES]

        else
          hsize = (bytes / PB_BYTES).round(2)
          unit =  HUMANIZED_BYTE_UNITS[PB_BYTES]

        end

        "#{hsize} #{unit}"
      end

    end # module

  end # module

end # module
