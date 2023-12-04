# generate equivalent of Mark C format _gfx.* from MAME tilesaving edition gfxrips

#from PIL import Image,ImageOps
import os,glob,collections,itertools

this_dir = os.path.abspath(os.path.dirname(__file__))
tiles_file = os.path.join(this_dir,os.pardir,"mame","136066-1101.35a") # not included (copyright reasons LOL!)

game_name = "tetris"
text_bitmap = " .=#/:_%()@&*+:;!"
nb_tiles = 0x800

def count_color(image):
    rval = set()
    for x in range(image.size[0]):
        for y in range(image.size[1]):
            p = image.getpixel((x,y))
            rval.add(p)

    return len(rval)

def write_tiles(blocks,size,f):
    for i,data in enumerate(blocks):
        f.write(f"  // ${i:X}\n  {{\n   ")
        offset = 0
        for k in range(size[1]):
            for j in range(size[0]):
                f.write("0x{:02d},".format(data[offset+j]))
            f.write("    // ")
            for j in range(size[0]):
                f.write(text_bitmap[data[offset+j]])
            f.write("\n   ")
            offset+=size[0]
        f.write("   },\n")

tiles = []
with open(tiles_file,"rb") as f:
    for _ in range(nb_tiles):
        # each 8x8 tile is 32 bytes each
        # each half-byte is a pixel 0-F being the index of the selected CLUT
        data = iter(f.read(32))
        current = []
        for y in range(8):
            for x in range(4):
                c = next(data)
                upper_nibble = (c & 0xF0)>>4
                lower_nibble = (c & 0xF)
                current.append(upper_nibble)
                current.append(lower_nibble)

        tiles.append(current)

with open(os.path.join(this_dir,f"{game_name}_gfx.h"),"w") as f:
        inc_protect = f"__{game_name.upper()}_GFX_H__"
        f.write(f"""#ifndef {inc_protect}
#define {inc_protect}


#define NUM_TILES {nb_tiles}

#endif //  {inc_protect}
"""
)
with open(os.path.join(this_dir,f"{game_name}_gfx.c"),"w") as f:
    f.write(f"""#include "{game_name}_gfx.h"

// tile data
""")
    sz = (8,8)
    f.write(f"uint8_t tile[NUM_TILES][{sz[0]*sz[1]}] =\n{{")

    write_tiles(tiles,sz,f)

    f.write("};\n")
