module Ancestry
  send :remove_const, :ANCESTRY_PATTERN
  const_set :UUID_PATTERN, '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}'
  const_set :ANCESTRY_PATTERN, %r{\A#{UUID_PATTERN}(\/#{UUID_PATTERN})*\Z}
end