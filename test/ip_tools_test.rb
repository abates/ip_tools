require 'test_helper'

class IpToolsTest < ActiveSupport::TestCase
  class ValidatesIpTest < ActiveRecord::Base
    validates_ip :ip
  end

  class ValidatesProtocolTest < ActiveRecord::Base
    validates_protocol :protocol_id
  end

  def test_validates_ip
    model = ValidatesIpTest.new
    model.ip = "0:0:0:0:0:0:0:0"
    assert model.valid?

    model.ip = "ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff" 
    assert model.valid?

    model.ip = "ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff/48" 
    assert model.valid?

    model.ip = "1050:0:0:0:5:600:300c:326b" 
    assert model.valid?

    model.ip = "1050::5:600:300c:326b"
    assert model.valid?

    model.ip = "ff06::c3" 
    assert model.valid?

    model.ip = "ffff::" 
    assert model.valid?

    model.ip = "::ffff"
    assert model.valid?

    model.ip = "ffff::ffff::ffff" # invalid!
    assert !model.valid?

    model.ip = "ffff:ffff:ffff:ffff:ffff:ffff:ffff:fffg" # invalid!
    assert !model.valid?

    model.ip = "192.168.1.1"
    assert model.valid?

    model.ip = "256.168.1.1"
    assert !model.valid?

    model.ip = "a.b.c.d"
    assert !model.valid?

    model.ip = "qwerty"
    assert !model.valid?
  end

  def test_validates_protocol
    model = ValidatesProtocolTest.new
    model.protocol_id = "100"
    assert model.invalid?

    model.protocol_id = "1"
    assert model.valid?
  end
end
