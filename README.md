# Pixar's Ruby Extensions

This gem defines extensions to modules and classes in Ruby's Core and Standard Library. We've put them here because we've found ourselves performing these tasks repeatedly in our code over the years and we like to stay DRY.

They are also used embedded in our open-source projects, and their use there will be migrating to use this gem - also in pursuit of DRYness.

To ease troubleshooting and prevent name collisions:

- Methods are not directly monkey-patched into the Core or StdLib classes/modules.
  - Instead they are defined in modules under `PixarRubyExtensions` with obvious namespaces, and mixed-in to the Core or StdLib classes/modules.

    This provides _much_ easier debugging when there are exceptions, since the error and backtrace will indicate exactly where these methods are defined.

- With only a couple of exceptions, all monkey-patched method names are prefixed with `pix_`
  - See `PixarRubyExtensions::IPAddr::Predicates` for examples and explanation

### Usage

To load all the extensions: `require 'pixar_ruby_extensions'`

To load only one: `require 'pixar_ruby_extensions/integer'`

### Credits

- The modularization idea came to me from [this page about responsible monkey-patching](https://www.justinweiss.com/articles/3-ways-to-monkey-patch-without-making-a-mess/), many thanks to the author and the discussion thread.

### ToDo

- Investigate re-doing all this using refinements rather than monkey-patching