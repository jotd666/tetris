from PIL import Image
import os,re,ast,io,glob

gamename = "tetris"

this_dir = os.path.dirname(__file__)

block_dict = {}

# hackish convert of c gfx table to dict of lists
# (reusing Mark Mc Dougall ripped gfx as C tables format, now I'm producing it
# with MAME ROM + custom python scripts)
with open(os.path.join(this_dir,f"{gamename}_gfx.c")) as f:
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


screen = Image.new("RGB",(336,240))

tile_list = block_dict["tile"]["data"]

for s in glob.glob(os.path.join(this_dir,"screens/*.bin")):
    with open(s,"rb") as f:
        contents = f.read()

    palettes = contents[0x1000:]

    cluts = [palettes[i:i+16] for i in range(0,256,16)]
    # we need to convert to RGB

    cluts = [[((c&0xE0),(c<<3)&0xE0,(c<<6)&0xE0) for c in clut] for clut in cluts]

    f = io.BytesIO(contents)
    x = 0
    y = 0
    for y in range(0,screen.size[1],8):
        for x in range(0,screen.size[0],8):
            c1 = ord(f.read(1))
            c2 = ord(f.read(1))
            palette_index = c2>>4
            tile_index = c1 + ((c2&0x7)<<8)

            clut_pal = cluts[palette_index]

            src = tile_list[tile_index]
            its = iter(src)
            for dy in range(8):
                for dx in range(8):
                    tv = next(its)
                    screen.putpixel((x+dx,y+dy),clut_pal[tv])

        f.seek((512-336)//4,1)       # skip the rest of row

    screen.save(os.path.join(this_dir,os.path.splitext(os.path.basename(s))[0]+".png"))

