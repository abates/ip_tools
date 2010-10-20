require File.dirname(__FILE__) + '/../../../../test/test_helper'
plugin_path = File::dirname(__FILE__) + '/..'
schema_file = plugin_path + "/test/db/schema.rb"
load(schema_file) if File.exist?(schema_file)

