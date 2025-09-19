# Copyright 2025 Pixar
#
#    Licensed under the terms set forth in the LICENSE.txt file available at
#    at the root of this project.

# frozen_string_literal: true

module PixarRubyExtensions

  module JSONExtensions

    # Add support for jsonlines (.jsonl) files
    # See https://jsonlines.org/
    #
    # See also Array#pix_to_jsonl
    #
    module JSONL

      # Read a jsonlines file and return an array of objects, with the addition of
      # ignoring comment lines, as with JSONExtensions::Utils#pix_parse
      #
      # @param source [String] the string of JSON to be parsed
      #
      # @param comment_string [String] the string that marks the start
      #   of a comment line, possibly with leading whitespace. Default is '#'
      #
      # @return [Object] The parsed JSON
      ####################
      def pix_parse_jsonl(source, comment_string: '#', **opts)
        src = pix_strip_comments(source, comment_string: comment_string)
        src.split("\n").map { |line| JSON.parse(line, **opts) }
      end

      # Generate a jsonlines string from an array of objects.
      #
      # @param objects [Array<Object>] the objects to be turned into jsonlines
      #
      # @return [String] The jsonlines string
      ####################
      def pix_generate_jsonl(objects, **opts)
        raise TypeError, "Expected an Array, got a #{objects.class}" unless objects.is_a? Array

        objects.map { |obj| JSON.generate(obj, **opts) }.join("\n")
      end

    end # module

  end # class

end # module
