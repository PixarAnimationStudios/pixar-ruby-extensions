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

  module Time

    module Utils

      # @return [Integer] the milliseconds of the Time
      def pix_msec
        strftime('%L').to_i
      end

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
        strftime("%FT%T.#{p_msec}%z")
      end

    end

  end

end
