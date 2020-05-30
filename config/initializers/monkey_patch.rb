require 'core_extensions/integer'
require 'core_extensions/string'
require 'core_extensions/date'
require 'core_extensions/hash'
require 'core_extensions/numeric'
require 'core_extensions/float'

Integer.include CoreExtensions::Integer
String.include CoreExtensions::String
Float.include CoreExtensions::Float
Date.include CoreExtensions::Date
Hash.include CoreExtensions::Hash
Numeric.include CoreExtensions::Numeric
