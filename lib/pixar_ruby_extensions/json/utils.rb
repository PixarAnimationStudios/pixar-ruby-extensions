# Copyright 2025 Pixar
#
#    Licensed under the terms set forth in the LICENSE.txt file available at
#    at the root of this project.

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
