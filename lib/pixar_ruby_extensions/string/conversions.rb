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

  module String

    module Conversions

      TRUE_STR = 'true'
      FALSE_STR = 'false'

      # Convert the strings "true" and "false"
      # (after stripping whitespace and downcasing)
      # to true and false respectively
      #
      # Return nil if any other string.
      #
      # @return [Boolean,nil] the boolean value. Nil if n/a
      #
      def pix_to_bool
        case strip.downcase
        when TRUE_STR then true
        when FALSE_STR then false
        end # case
      end # to bool

      # Convert a string to a Time object using Time.parse
      #
      # @return [Time] the time represented by the string, or nil
      #
      def pix_to_time
        # needed to get .parse
        require 'time'

        Time.parse self
      rescue
        nil
      end

      # Convert a String to a Pathname object
      #
      # @return [Pathname]
      #
      def pix_to_pathname
        Pathname.new self
      end
      alias pix_to_path pix_to_pathname

      # Word-wrap a string to a max width.
      # By default, runs of newlines are preserved.
      #
      # Regexp found at http://www.java2s.com/Code/Ruby/String/WordwrappingLinesofText.htm
      #
      # @param width [Integer] Must be a positive Integer. Defaults to 2 columns less than
      #   the current terminal width, or 78 if terminal width cannot be obtained.
      #
      # @param preserve_newlines [Boolean] Should runs of 2+ newlines be preserved?
      #   Defaults to true. If false, runs of newlines become a single newline.
      #
      # @return [String] The string word-wrapped to lines no more than <width> chars long.
      #
      def pix_word_wrap(width = nil, preserve_newlines: true)
        if width.nil?
          begin
            require 'io/console'
            width = IO.console.winsize.last - 2
          rescue
            width = 78
          end
        else
          width = width.to_i
          raise ArgumentError, 'Width must be an iteger > 0' unless width.positive?
        end

        return lines.map { |l| l.gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n") }.join if preserve_newlines

        gsub(/(.{1,#{width}})(\s+|\Z)/, "\\1\n")
      end

    end # module

  end # module

end # module
