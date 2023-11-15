from PIL import Image

tiles = Image.open("tiles.png")

tile_list = []
for y in range(0,tiles.size[1],8):
    for x in range(0,tiles.size[0],8):
        tile = Image.new("RGB",(8,8))
        tile.paste(tiles,(-x,-y))
        tile_list.append(tile)

screen = Image.new("RGB",(336,240))

with open("screens/tetris_game.bin","rb") as f:
    x = 0
    y = 0
    for y in range(0,screen.size[1],8):
        for x in range(0,screen.size[0],8):
            c1 = ord(f.read(1))
            c2 = ord(f.read(1))
            palette_index = c2>>4
            tile_index = c1 + ((c2&0x7)<<8)
            if tile_index != 0:
                print(hex(tile_index))
            src = tile_list[tile_index]
            screen.paste(src,(x,y))
        f.seek((512-336)//4,1)       # skip the rest of row

screen.save("out.png")

