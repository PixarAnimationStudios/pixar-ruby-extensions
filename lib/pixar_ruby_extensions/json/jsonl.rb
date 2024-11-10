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

    # Add support for jsonlines (.jsonl) files
    # See https://jsonlines.org/
    #
    # See also Array#pix_to_jsonl
    #
    module JSONL

      # Read a jsonlines file and return an array of objects.
      # , with the addition of
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
