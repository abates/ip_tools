ActiveRecord::Schema.define(:version => 0) do
  create_table :validates_ip_tests, :force => true do |t|
    t.string :ip
  end

  create_table :validates_protocol_tests, :force => true do |t|
    t.integer :protocol_id
  end
end

