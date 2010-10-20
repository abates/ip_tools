require 'test_helper'

class IpToolsTest < ActiveSupport::TestCase
  class ValidatesIpTest < ActiveRecord::Base
    validates_ip :ip
  end

  def test_validator
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
end
