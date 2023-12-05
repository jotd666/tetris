import os,re,bitplanelib,ast,json,glob
from PIL import Image,ImageOps


import collections

def ensure_empty(d):
    if os.path.exists(d):
        for f in glob.glob(os.path.join(d,"*")):
            os.remove(f)
    else:
        os.mkdir(d)

gamename = "tetris"

this_dir = os.path.dirname(__file__)
src_dir = os.path.join(this_dir,"../../src/amiga")
tiles_dump_dir = os.path.join(this_dir,"dumps")


dump_tiles = False
if dump_tiles:
    if not os.path.exists(tiles_dump_dir):
        os.mkdir(tiles_dump_dir)

block_dict = {}

# hackish convert of c gfx table to dict of lists
# (reusing Mark Mc Dougall ripped gfx as C tables format, now I'm producing it
# with MAME ROM + custom python scripts)

with open(os.path.join(this_dir,"..",f"{gamename}_gfx.c")) as f:
    block = []
    block_name = ""
    start_block = False

    for line in f:
        if "uint8" in line:
            # start group
            start_block = True
            if block:
                txt = "".join(block).strip().strip(";")

                block_dict[block_name] = {"size":size,"data":ast.literal_eval(txt)}
                block = []
            block_name = line.split()[1].split("[")[0]
            size = int(line.split("[")[2].split("]")[0])
        elif start_block:
            line = re.sub("//.*","",line)
            line = line.replace("{","[").replace("}","]")
            block.append(line)

    if block:
        txt = "".join(block).strip().strip(";")
        block_dict[block_name] = {"size":size,"data":ast.literal_eval(txt)}



blocks = block_dict['tile']['data']

# it doesn't matter the palette as long as colors are different from each other, but it's
# better to have differentiated colors for dumps
base_palette = [0x0,0x1,0x010,0x001,0x101,0x110,0x011,0x100]
some_16_colors = [bitplanelib.rgb4_to_rgb_triplet(c) for c in [x*15 for x in base_palette] + [x*8 for x in base_palette]]

fillin = (10,56,23)  # random, but different from colors of some_16_colors

character_codes_list = []

for k,chardat in enumerate(blocks):
    img = Image.new('RGB',(8,8))

    character_codes = list()

    # generate 16 copies
    for cidx in range(16):
        chunksz = cidx*16
        # each local palette has 16 colors. Generate 256-color palette for each CLUT with only
        # 16 active colors
        palette = [fillin]*chunksz + some_16_colors + [fillin]*(240-chunksz)

        d = iter(chardat)
        for i in range(8):
            for j in range(8):
                v = next(d)

                c = some_16_colors[v]
                img.putpixel((j,i),c)

        character_codes.append(bitplanelib.palette_image2raw(img,None,palette))


        if cidx == 0 and dump_tiles:
            scaled = ImageOps.scale(img,5,0)
            picname = f"char_{k:03x}.png"
            scaled.save(os.path.join(tiles_dump_dir,picname))

    character_codes_list.append(character_codes)


def encode(c):
    r = 15
    # adjust so max is 15 for each component
    red = ((c&0xE0)*r)//14
    green = (((c<<3)&0xE0)*r)//14
    blue = (((c<<6)&0xE0)*r)//12
    return red,green,blue

if True:
    # generate color table (avoids computing it in real time, avoids the hassle in asm too)

    table = [bitplanelib.to_rgb4_color(encode(c)) for c in range(256)]

    with open(os.path.join(src_dir,"color_lut.68k"),"w") as f:
        f.write("color_table:")
        bitplanelib.dump_asm_bytes(table,f,mit_format=True,nb_elements_per_row=8,size=2)

    plane_cache = dict()
    key_index = 0

    with open(os.path.join(src_dir,"graphics.68k"),"w") as f:
        f.write("\t.global\tcharacter_table\n")



        f.write("character_table:\n")
        for i,c in enumerate(character_codes_list):
            # c is the list of the same character with 16 different cluts
            f.write(f"\t.long\tchar_{i}\n")

        for i,c in enumerate(character_codes_list):
            f.write(f"char_{i}:\n")
            # this is a table
            for j,cc in enumerate(c):
                f.write(f"\t.word\tchar_{i}_{j}-char_{i}\n")

            for j,cc in enumerate(c):
                charname = f"char_{i}_{j}"
                f.write(f"{charname}:\n")
                for k in range(8):

                    # only 4 of 8 bitplanes aren't all zeroes at most
                    ccc = cc[k*8:(k+1)*8]
                    if any(ccc):
                        key = plane_cache.get(ccc)
                        if not key:
                            key = f"plane_{key_index:04d}"
                            key_index += 1
                            plane_cache[ccc] = key
                        f.write(f"\tdc.w\t{key}-{charname}\n")


                    else:
                        f.write(f"\tdc.w\t0\n")

        # now dump plane data
        for k,v in sorted(plane_cache.items(),key = lambda t:t[1]):
            f.write(f"{v}:")
            bitplanelib.dump_asm_bytes(k,f,mit_format=True)