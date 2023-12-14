import gzip,struct

def error(msg):
    raise Exception(msg)

def read_4_bytes(offset):
    return contents[offset:offset+4]

def read_32bit_int(offset):
    z = read_4_bytes(offset)
    return struct.unpack("<I",z)[0]

with gzip.open("vgm/14 Pokey.vgz") as f:
    contents = f.read()

four_cc = read_4_bytes(0).decode(errors="ignore")

if four_cc != "Vgm ":
    error("Not a vgm file")

eof_offset = read_32bit_int(4)
version = read_32bit_int(8)
pokey_clock = read_32bit_int(0xB0)
vgm_data_offset = read_32bit_int(0x34)+0x34
gd3_offset = read_32bit_int(0x14)
if gd3_offset:
    gd3_offset += 0x14

if not pokey_clock:
    error("Not a pokey vgm file")


commands = iter(contents[vgm_data_offset:])
offset = vgm_data_offset

def wait(nb_frames):
    print(f"wait ${nb_frames:0x}")

def dump_pokey(idx,pokey_freq):
    freq1 = (pokey_freq[0]*256+pokey_freq[1])
    freq2 = (pokey_freq[2]*256+pokey_freq[3])

    print(f"{idx}: {freq1} {freq2}")
def get_byte():
    global offset
    offset+=1
    return next(commands)
def get_word():
    global offset
    offset+=2
    return next(commands) + next(commands)*256

pokey_1_freq = [0]*4
pokey_2_freq = [0]*4
# assuming dividers are connected

while offset < gd3_offset:
    c = get_byte()
    # wait command
    if c==0x61:
        w = get_word()
    elif c==0x62:
       wait(0x2DF)
    elif c==0x63:
        wait(0x372)
    elif c==0x66:
        break
    elif (c&0xF0)==0x70:
        wait((c&0xf) + 1)
        pass
    elif c==0xBB:
        reg = get_byte()
        val = get_byte()
        if reg & 0xF == 0x8:
            print(f"Write {val:02x} to control {reg:02x}")
        elif reg % 2 == 0:
            if reg & 0x80:
                # pokey 2
                p = pokey_2_freq
            else:
                p = pokey_1_freq

            idx = (reg & 0xF)>>1
            p[idx] = val

            print(f"Write {val:02x}/{val:02d} to {reg:02x}")
            dump_pokey(1,pokey_1_freq)
            dump_pokey(2,pokey_2_freq)

    else:
        error(f"Unknown command ${c:0x} at offset ${offset:0x}")
