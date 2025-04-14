import re

with open('custom.hex', 'r') as f:
    lines = f.readlines()

formatted = []
current_word = ""

# Remove comments and address headers
for line in lines:
    line = line.split('#')[0].strip()  # Remove comments
    if not line:
        continue
    if line.startswith('@'):
        continue
    # Remove whitespace and add to formatted lines
    line = re.sub(r'\s+', '', line)
    formatted.append(line)

# Write the formatted hex file
with open('test.hex', 'w') as f:
    for line in formatted:
        # Insert a line break every 8 characters (32 bits)
        for i in range(0, len(line), 8):
            if i+8 <= len(line):
                f.write(line[i:i+8] + '\n')
