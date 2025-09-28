import re
src = "../src/tetris.68k"
nb = 0
prev_loaded = None
with open(src) as f:
    lines = list(f)

def remcomments(line):
    return re.sub("[\|\*].*","",line)

new_lines = []

for i,line in enumerate(lines):
    orig_line = line
    line = remcomments(line)  # remove comments
    toks = line.split()
    if any(x in toks for x in ("GET_ADDRESS","GET_UNCHECKED_ADDRESS")):
        value = toks[1]
        if prev_loaded == value and i-prev_line < 6:
            print(f"Prev loaded: {prev_loaded} line {i+1} loaded at line {prev_line+1}")
            orig_line = re.sub(".*\|","\t* no reload |",orig_line)
            nb += 1
        prev_line = i
        prev_loaded = value
    if any(x in toks for x in ["GET_ADDRESS_Y","SBC_X","SBC_Y","SBC_IMM","rts","jmp","jra","jbsr"]):
        prev_loaded = None
    if re.match("\w+:",line):
        prev_loaded = None

    new_lines.append(orig_line)


print(f"found {nb} GET_ADDRESS useless occs")
with open("tetris.68k","w") as f:
    f.writelines(new_lines)