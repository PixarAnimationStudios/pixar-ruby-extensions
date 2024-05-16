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

  module HashExtensions

    module Utils

      # Convert certain Hash values to nil, optionally recursively
      #
      # This is useful when a dataset lacks consistency as to
      # whether unset values come as nils or empty strings.
      #
      # By default this method converts all empty strings to nils,
      # but other target strings can be provided.
      #
      # With no block, values equalling the given String (default is the empty string),
      # or any member of a given Array of Strings will be converted to nil.
      # Equality is evaluated with Array#include?
      #
      # With a block, the to_nils param is ignored, and if the result of the block
      # evaluates to true, the value is converted to nil.
      #
      # Subhashes are ignored unless recurse is true.
      #
      # @param to_nils[String,Array] Hash values equal to (==) these become nil. Defaults to empty string
      #
      # @param recurse[Boolean] should sub-Hashes be nillified?
      #
      # @yield [value] Hash values for which the block returns true will become nil.
      #
      # @return [Hash] the hash with the desired values converted to nil
      #
      # @example
      #   hash = {:foo => '', :bar => {:baz => '' }}
      #   hash.jss_nillify!  # {:foo => nil, :bar => {:baz => '' }}
      #
      #   hash = {:foo => '', :bar => {:baz => '' }}
      #   hash.jss_nillify! '', :recurse  # {:foo => nil, :bar => {:baz => nil }}
      #
      #   hash = {:foo => 123, :bar => {:baz => '', :bim => "123" }}
      #   hash.jss_nillify! ['', 123], :recurse # {:foo => nil, :bar => {:baz => nil, :bim => "123" }}
      #
      #   hash = {:foo => 123, :bar => {:baz => '', :bim => "123" }}
      #   hash.jss_nillify!(:anything, :recurse){|v| v.to_i == 123 }  # {:foo => nil, :bar => {:baz => '', :bim => nil }}
      #
      def pix_nillify(to_nils = '', recurse: false, &block)
        p_nillifier(to_nils, recurse: recurse, destructive: false, &block)
      end # def nillify

      # Modify self in-place.
      #
      # @see p_nillify
      #
      def pix_nillify!(to_nils = '', recurse: false, &block)
        p_nillifier(to_nils, recurse: recurse, destructive: true, &block)
      end

      private

      def pix_nillifier(to_nils, recurse:, destructive:, &block)
        nillify_these = [to_nils].flatten

        if destructive
          transformer = :transform_values!
          nillifier = :p_nillify!
        else
          nillifier = :p_nillify
          transformer = :transform_values
        end

        send transformer do |v|
          if v.is_a?(Hash) && recurse
            # puts :recursing
            v = v.send(nillifier, to_nils, recurse: recurse, &block)
            # puts "new v is: #{v}"
            v
          else
            do_it = block_given? ? yield(v) : nillify_these.include?(v)
            do_it ? nil : v
          end # if
        end # transform values
      end

    end # module

  end # module

end # module
