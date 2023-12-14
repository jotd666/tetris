#if (size == 17)
#	{
#		for (uint32_t i = 0; i < mask; i++)
#		{
#			// calculate next bit @ 7
#			const uint32_t in8 = BIT(lfsr, 8) ^ BIT(lfsr, 13);
#			const uint32_t in = BIT(lfsr, 0);
#			lfsr = lfsr >> 1;
#			lfsr = (lfsr & 0xff7f) | (in8 << 7);
#			lfsr = (in << 16) | lfsr;
#			*poly = lfsr;
#			LOG_RAND("%05x: %02x\n", i, *poly);
#			poly++;
#		}
#	}

size = 17
mask = (1 << size) - 1
poly = []
lfsr =mask;

def BIT(x,v):
    return (x>>v)&1

for i in range(2**size):
    # calculate next bit @ 7
    in8 = BIT(lfsr, 8) ^ BIT(lfsr, 13)
    _in = BIT(lfsr, 0)
    lfsr = lfsr >> 1
    lfsr = (lfsr & 0xff7f) | (in8 << 7)
    lfsr = (_in << 16) | lfsr
    poly.append(lfsr)

for i in range(100):
    print(hex((poly[i]>>8)&0xFF))