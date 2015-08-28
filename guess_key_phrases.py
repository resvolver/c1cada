# This program allows you to specify a part of a key, and a section number.
# It then applies the key shift on every [key_length] length consecutive runes
# from the specified section, and prints the shifted runes (with whitespace)
# and the position where the key was applied, and the shift direction (forward or backward).
#
# Usage: python3 guess_key_phrases.py <key_phrase> <section_number>
#
# The key is specified in english as a command line argument, and so is the section number.
# The key is then translated in runes by the program to apply the shifts.
# Output is stored in folder key_phrases/, and the file name corresponds
# to the key phrase followed by underscore and section number.

import sys
import re

# Will contain all sections of the Liber Primus rune book
liber_primus = []

table = [
    ["ᚠ", "F"], 
    ["ᚢ", "U"],
    ["ᚦ", "TH"],
    ["ᚩ", "O"],
    ["ᚱ", "R"],
    ["ᚳ", "C"],
    ["ᚷ", "G"],
    ["ᚹ", "W"],
    ["ᚻ", "H"],
    ["ᚾ", "N"],
    ["ᛁ", "I"],
    ["ᛂ", "J"],
    ["ᛇ", "EO"],
    ["ᛈ", "P"],
    ["ᛉ", "X"],
    ["ᛋ", "S"],
    ["ᛏ", "T"],
    ["ᛒ", "B"],
    ["ᛖ", "E"],
    ["ᛗ", "M"],
    ["ᛚ", "L"],
    ["ᛝ", "ING"],
    ["ᛟ", "OE"],
    ["ᛞ", "D"],
    ["ᚪ", "A"],
    ["ᚫ", "AE"],
    ["ᚣ", "Y"],
    ["ᛡ", "IA"],
    ["ᛠ", "EA"]
]

# Not used currently, but can retrieve the list of words form Liber Primus.
# This list of words was found from https://titanpad.com/dgqETedGby
# I removed the occurence counts so that words begin on position 0 in the lines.
def get_liber_primus_words():
    word_list = []

    f = open('liber_primus_words.rne', 'r')
    
    for line in f.readlines():
        word_list.append(line.strip())

    f.close()
    return word_list

# Retrieves the Liber Primus sections from the rune transcriptions
# found in https://titanpad.com/hJ8pVQ5S43
# The plain text was deleted, so only the rune text remains in transcriptions.rne
def get_liber_primus():
    sections = []
    pages = []
    
    f = open('transcriptions.rne')
    contents = f.read()
    f.close()

    n = 0
    for page in contents.split('\n\n'):
        if n == 50:     # This is the page consisting entirely of bigrams (sexagesimal cipher?)
            pages.append("")    # Ignore this page

        pages.append(re.sub("\n", "", page))
        n += 1

    # I divided the sections according to the imagery changes.
    # This isn't really an 'official' division, so feel free to change the page numbers.
    # Section 9 corresponds to page 56 (the primes - 1 stream cipher)
    # Section 10 corresponds to page 57 (the plaintext parable)
    #
    # All non-runic characters are removed (except the dots for spacing info)
    sections.append(re.sub("[ A-Za-z0-9\"\']", "", "".join(pages[0:3])))
    sections.append(re.sub("[ A-Za-z0-9\"\']", "", "".join(pages[3:8])))
    sections.append(re.sub("[ A-Za-z0-9\"\']", "", "".join(pages[8:15])))
    sections.append(re.sub("[ A-Za-z0-9\"\']", "", "".join(pages[15:23])))
    sections.append(re.sub("[ A-Za-z0-9\"\']", "", "".join(pages[23:27])))
    sections.append(re.sub("[ A-Za-z0-9\"\']", "", "".join(pages[27:33])))
    sections.append(re.sub("[ A-Za-z0-9\"\']", "", "".join(pages[33:40])))
    sections.append(re.sub("[ A-Za-z0-9\"\']", "", "".join(pages[40:54])))
    sections.append(re.sub("[ A-Za-z0-9\"\']", "", "".join(pages[54:56])))
    sections.append(re.sub("[ A-Za-z0-9\"\']", "", "".join(pages[56])))
    sections.append(re.sub("[ A-Za-z0-9\"\']", "", "".join(pages[57])))
    return sections

## Translate an english string in runes
## Tries to find the minimal rune representation of the string
##
## Note: QU is translated into ᚳᚹ (CW).
## Thanks to Nem0 for the advice on how to do this!
def english_to_runes(string):
    runes = ["ᛝ", "ᚦ", "ᛇ", "ᛝ", "ᛟ", "ᚫ", "ᛡ", "ᛡ", "ᛠ", "ᚳᚹ", "ᚠ", "ᚢ", "ᚢ", "ᚩ", "ᚱ", "ᚳ", "ᚳ", "ᚳ", "ᚷ", "ᚹ", "ᚻ", "ᚾ", "ᛁ", "ᛂ", "ᛈ", "ᛉ", "ᛋ", "ᛋ", "ᛏ", "ᛒ", "ᛖ", "ᛗ", "ᛚ", "ᛞ", "ᚪ", "ᚣ"]
    chars = ["ING", "TH", "EO", "NG", "OE", "AE", "IA", "IO", "EA", "QU", "F", "U", "V", "O", "R", "C", "K", "Q", "G", "W", "H", "N", "I", "J", "P", "X", "S", "Z", "T", "B", "E", "M", "L", "D", "A", "Y"]

    string = string.upper()
    for char in chars:
        string = re.sub(char, runes[chars.index(char)], string)

    return string

# Translate runes into english. This is not quite perfect, as it does not handle
# equivalent english rune equivalents.
# Ex.: "ᛝ" is always translated as ING, although it could be NG (see table above)
def runes_to_english(runeword):
    dictable = {entry[0]:entry[1] for entry in table}
    res = ""
    for rune in runeword:
        res += dictable[rune]

    return res

# Returns position of rune in gematria order (starting from 0 for F)
def get_rune_pos(rune):
    for i in range(len(table)):
        if rune in table[i]:
            return i

    return None

# Applies the key shift from ansatz on the given runic text, returning the shifted text.
# The output is translated from runes to english to be more readable.
# Direction is 0 if position of ansatz runes is to be *added* to the text runes
# Direction is 1 if position of ansatz runes is to be *subtracted* from the text runes
#
# Dots are handled by replacing them with spaces
def shifted_text(text, ansatz, direction):
    shifted = ""

    j = 0
    i = 0
    while i < len(ansatz) and j < len(text):
        rune1 = text[j]
        rune2 = ansatz[i]
        
        # Dots become spaces
        if rune1 == "•":
            shifted += " "
            j += 1
            continue

        pos1 = get_rune_pos(rune1)
        pos2 = get_rune_pos(rune2)

        new_pos = 0

        if direction == 0:
            new_pos = (pos1 + pos2) % 29
        else:
            new_pos = (pos1 - pos2) % 29
        
        shifted += table[new_pos][1]
        j += 1
        i += 1

    return shifted

if len(sys.argv) < 3:
    print("Usage: python3 guess_key_phrases.py <key_phrase> <section_number>")
    quit()

ansatz = sys.argv[1]
SECTION_NUM = int(sys.argv[2])

rune_ansatz = english_to_runes(ansatz)
liber_primus = get_liber_primus()
section = liber_primus[SECTION_NUM]

f = open('key_phrases/' + ansatz + '_' + str(SECTION_NUM) + '.txt', 'a')
f.write('------- BEGIN KEY \"' + ansatz + '\" -------\n')
f.write('SECTION ' + str(SECTION_NUM) + '\n\n')

# Apply the key shift on every consecutive string of same length as the key.
# Both forwards and backwards.
for i in range(len(section) - len(rune_ansatz)):
    f.write("Pos: " + "%-6s"%str(i) + " Forward :\t" + shifted_text(section[i:], rune_ansatz, 0) + '\n')
    f.write("Pos: " + "%-6s"%str(i) + " Backward:\t" + shifted_text(section[i:], rune_ansatz, 1) + '\n')

f.write('------- END KEY \"' + ansatz + '\" -------\n')
f.close()
