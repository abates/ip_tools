ActiveRecord::Schema.define(:version => 0) do
  create_table :validates_ip_tests, :force => true do |t|
    t.string :ip
  end
end

