# Copyright 2025 Pixar
#
#    Licensed under the terms set forth in the LICENSE.txt file available at
#    at the root of this project.

# frozen_string_literal: true

module PixarRubyExtensions

  module FileTestExtensions

    module Predicates

      # FileTest.file? returns true if
      # the item is a symlink pointing to a regular file.
      #
      # This test, real_file?, returns true if the item is
      # a regular file but NOT a symlink.
      #
      def pix_real_file?(path)
        FileTest.file?(path) && !FileTest.symlink?(path)
      end # real_file?

      # FileTest.directory? returns true if
      # the item is a symlink pointing to a directory.
      #
      # This test, real_directory?, returns true if the item is
      # a directory but NOT a symlink.
      #
      def pix_real_directory?(path)
        FileTest.directory?(path) && !FileTest.symlink?(path)
      end # real_file?

    end # module

  end # module

end # module
