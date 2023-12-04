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
palette = [x*15 for x in base_palette] + [x*8 for x in base_palette]


for k,chardat in enumerate(blocks):
    img = Image.new('RGB',(8,8))


    character_codes = list()

    for cidx,colors in enumerate(rgb_cluts):
        if not used_cluts or (k in used_cluts and cidx in used_cluts[k]):
            d = iter(chardat)
            for i in range(8):
                for j in range(8):
                    v = next(d)
                    c = colors[v]
                    tiles_used_colors.add(c)
                    img.putpixel((j,i),c)
            picname = f"char_{k:03x}_{cidx:02x}.png"
            character_codes.append(bitplanelib.palette_image2raw(img,None,palette))


            if dump_tiles:
                scaled = ImageOps.scale(img,5,0)
                scaled.save(os.path.join(tiles_dump_dir,picname))
        else:
            character_codes.append(None)
    character_codes_list.append(character_codes)


if False:
    with open(os.path.join(src_dir,"graphics.68k"),"w") as f:
        f.write("\t.global\tcharacter_table\n")



        f.write("character_table:\n")
        for i,c in enumerate(character_codes_list):
            # c is the list of the same character with 31 different cluts
            if any(c):
                f.write(f"\t.long\tchar_{i}\n")
            else:
                f.write("\t.long\t0\n")
        for i,c in enumerate(character_codes_list):
            if any(c):
                f.write(f"char_{i}:\n")
                # this is a table
                for j,cc in enumerate(c):
                    if cc is None:
                        f.write(f"\t.word\t0\n")
                    else:
                        f.write(f"\t.word\tchar_{i}_{j}-char_{i}\n")

                for j,cc in enumerate(c):
                    if cc is not None:
                        f.write(f"char_{i}_{j}:")
                        bitplanelib.dump_asm_bytes(cc,f,mit_format=True)
