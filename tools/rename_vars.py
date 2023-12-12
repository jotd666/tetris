import re



def apply_ram(m):
    g = m.group(1).strip(" $")
    address = int(g,16)
    if address < 0x1000:
        return "\tunknown_{:04x}".format(address)
    else:
        return "\t${}".format(g)

with open("../src/tetris_6502.asm","r") as f:
    contents = f.read()


replaced = re.sub("\s(\$[0-9A-F]+)",apply_ram,contents,flags=re.I)

with open("tetris_6502_.asm","w") as f:
    f.write(replaced)
