s ="""78 41 7D 41 8A 41 9A 41 A5 41 BE 41 E0 41 05 42
 EB 42 88 42 23 42 5A 42 26 44 A4 42 26 44 26 44
 26 44 26 44 26 44 26 44 26 44"""

toks = s.split()
for i in range(0,len(toks),2):
    # adds 1 because 6502 stack works differently from 68000
    addr = int(toks[i+1]+toks[i],16)
    print(f"\t.word\t${addr+1:04x}")

print()

for i in range(0,len(toks),2):
    # adds 1 because 6502 stack works differently from 68000
    addr = int(toks[i+1]+toks[i],16)
    print(f"\t.long\tl_{addr+1:04x}")
