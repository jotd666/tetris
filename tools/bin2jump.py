s ="""07 80 9F 81 D7 81 01 83 21 83 5C 83 8A 83 B1 83
26 84 3D 84 60 84 BE 84 DC 84 0F 85 55 85 67 85
93 85 A7 85 36 86 56 86 E9 86 56 86
"""

toks = s.split()
for i in range(0,len(toks),2):
    # adds 1 because 6502 stack works differently from 68000
    addr = int(toks[i+1]+toks[i],16)
    print(f"\t.word\t${addr+1:04x}")
