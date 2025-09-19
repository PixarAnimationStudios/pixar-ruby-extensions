# Copyright 2025 Pixar
#
#    Licensed under the terms set forth in the LICENSE.txt file available at
#    at the root of this project.

# frozen_string_literal: true

module PixarRubyExtensions

  module PathnameExtensions

    module Predicates

      # Is this a real file rather than a symlink?
      # @see FileTest.pix_real_file?
      def pix_real_file?
        FileTest.pix_real_file? self
      end

      # Is this a real directory rather than a symlink?
      # @see FileTest.pix_real_directory?
      def pix_real_directory?
        FileTest.pix_real_directory? self
      end

      # does a path include another?
      # i.e. is 'other' a descendant of self ?
      def pix_include?(other)
        eps = expand_path.to_s
        oeps = other.expand_path.to_s
        oeps != eps && oeps.start_with?(eps)
      end

    end # module

  end # module

end # module
