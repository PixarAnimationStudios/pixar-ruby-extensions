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

  module JSONExtensions

    module Utils

      # The same as JSON.parse, except whole-line comments are
      # stripped from source before its parsed.
      #
      # Comment lines start with zero or more whitespace followed
      # by the comment string, which by default is '#' but you
      # can pass in others, such as '--'
      #
      # NOTE: Even though the JSON standard does not include
      # support for comments, apprarently the Ruby JSON.parse
      # method does honor '//' comments. I only discovered that
      # when testing this method.
      # I'm leaving it here though because we already use #
      # comments, and that's the kind that YAML uses
      #
      # This command doesn't support or recognize in-line comments
      # only whole-line comments.
      #
      # See JSON.parse for the standard opts and return value
      #
      # @param source [String] the string of JSON to be parsed
      #
      # @param comment_string [String] the string that marks the start
      #   of a comment line, possibly with leading whitespace.
      #
      # @return [Object] The parsed JSON
      #
      def pix_parse(source, comment_string: '#', **opts)
        src = pix_strip_comments(source, comment_string: comment_string)
        JSON.parse src, **opts
      end

      # See pix_parse and JSON.parse!
      def pix_parse!(source, comment_string: '#', **opts)
        src = pix_strip_comments(source, comment_string: comment_string)
        JSON.parse! src, **opts
      end

      # See pix_parse and JSON.load_file
      def pix_load_file(filespec, comment_string: '#', **opts)
        pix_parse File.read(filespec), comment_string: comment_string, **opts
      end

      # See pix_parse and JSON.load_file!
      def pix_load_file!(filespec, comment_string: '#', **opts)
        pix_parse! File.read(filespec), comment_string: comment_string, **opts
      end

      # remove comment lines from a string
      #
      # @param source [String] the string from which to remove comment lines
      #
      # @param comment_string [String] the string that marks the
      #   start of a commend line, possibly with leading whitespce
      #
      # @return [String] the string with comment lines removed.
      #
      def pix_strip_comments(source, comment_string: '#')
        source.lines.reject { |l| l =~ /^\s*#{comment_string}/ }.join
      end

    end # module

  end # class

end # module
