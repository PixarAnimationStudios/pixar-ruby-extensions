# Copyright 2025 Pixar
#
#    Licensed under the terms set forth in the LICENSE.txt file available at
#    at the root of this project.

# frozen_string_literal: true

module PixarRubyExtensions

  module PathnameExtensions

    module Utils

      # Copy a path to a destination
      # @see FileUtils.cp
      def pix_cp(dest, **options)
        FileUtils.cp @path, dest.to_s, **options
      end # cp

      # Recursively copy this path to a destination
      # @see FileUtils.cp_r
      def pix_cp_r(dest, **options)
        FileUtils.cp_r @path, dest.to_s, **options
      end # cp

      # Write some string content to a file.
      #
      # Simpler than always using an open('w') block
      #
      # *CAUTION* this overwrites files!
      #
      def pix_save(content)
        self.open('w') { |f| f.write content.to_s }
      end

      # Append some string content to a file.
      #
      # Simpler than always using an open('a') block
      #
      def pix_append(content)
        self.open('a') { |f| f.write content.to_s }
      end

      # Not sure why this isn't in Pathname to begin with
      #
      # @see FileUtils.touch
      def pix_touch
        FileUtils.touch @path
      end

      # Pathname should use FileUtils.chown, not File.chown, its friendlier
      def pix_chown(usr, grp)
        FileUtils.chown usr, grp, @path
      end

      # Pathnames often need to be escaped for the shell
      def pix_shellescape
        require 'shellwords'
        to_s.shellescape
      end

      # This allows us to write out to a file which many other
      # threads or processes are reading, and not worry about
      # them reading a partial file.
      # It does so by writing into a temp file in the same directory,
      # then renaming the file into the path `self`
      #
      # NOTE: There is much discussion online about the atomicity of
      # unix 'rename' but in general as long as you're dealing with
      # a single file, not a directory, and you are not moving it across
      # filesystems, then yes, it will be atomic.
      #
      # WARNING: This will overwrite the current file.
      #
      # @param data [String] the data to write into the file.
      #
      # @return [void]
      #
      def pix_atomic_write(data)
        raise "#{self} is a directory" if directory?

        require 'tempfile'
        tmpf = Pathname.new Tempfile.create(
          ['.atomic_write', '.tmp'],
          parent.to_s
        )

        if file?
          ostat = stat
          mode = ostat.mode
          uid = ostat.uid
          gid = ostat.gid
        else
          mode = 0o644
          uid = nil
          gid = nil
        end

        tmpf.chmod mode
        tmpf.pix_chown(uid, gid) if uid && gid

        tmpf.open('w+') { |f| f.write data }
        tmpf.rename self
      ensure
        tmpf.delete if tmpf && tmpf.file?
      end # end atomic_write

      # DEPRECATED: use the pix_ version of this method
      alias atomic_write pix_atomic_write

      # @see PixarRubyExtensions::IntegerExtensions::Utils#pix_humanize_bytes
      #
      # @return [String] The human-readable file size.
      #
      def pix_humanize_size
        # make sure we require this, in case the user only required
        # 'pixar_ruby_extensions/pathname'
        require 'pixar_ruby_extensions/integer'
        size.pix_humanize_bytes
      end

      # The same as #pix_humanize_size except returns nil if
      # the file size is zero, or the file doesn't exist.
      #
      # @return [String, nil] The human-readable file size, or nil
      def pix_humanize_size?(show_unit: false)
        return unless exist?
        return if size.zero?

        humanize_size
      end

    end # module

  end # module

end # module
