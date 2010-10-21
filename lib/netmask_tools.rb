class IPAddr
  def inverse_mask
    length=32
    if (ipv6?)
      length=128
    end
    return IPAddr.new((2**length-@mask_addr-1), family)
  end

  def netmask
    return IPAddr.new(@mask_addr, family)
  end

  def broadcast
    length=32
    if (ipv6?)
      length=128
    end
    return IPAddr.new(to_i | 2**length - @mask_addr-1, family)
  end

  def prefix
    return(0) if (@mask_addr == 0)
    length=32
    if (ipv6?)
      length=128
    end

    mask = nil
    netmask_int = @mask_addr
    if (netmask_int < 2**length)
        mask = length
    else
        mask = 128
    end

    mask.times do
        if ((netmask_int & 1) == 1)
            break
        end
        netmask_int = netmask_int >> 1
        mask = mask - 1
    end
    return(mask)
  end
end

