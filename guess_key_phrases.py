import re

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


## Translate an english string in runes
## Tries to find the minimal rune representation of the string
##
## Thanks to Nem0 for the advice on how to do this!
def english_to_runes(string):
    runes = ["ᛝ", "ᚦ", "ᛇ", "ᛝ", "ᛟ", "ᚫ", "ᛡ", "ᛡ", "ᛠ", "ᚳᚹ", "ᚠ", "ᚢ", "ᚢ", "ᚩ", "ᚱ", "ᚳ", "ᚳ", "ᚳ", "ᚷ", "ᚹ", "ᚻ", "ᚾ", "ᛁ", "ᛂ", "ᛈ", "ᛉ", "ᛋ", "ᛋ", "ᛏ", "ᛒ", "ᛖ", "ᛗ", "ᛚ", "ᛞ", "ᚪ", "ᚣ"]
    chars = ["ING", "TH", "EO", "NG", "OE", "AE", "IA", "IO", "EA", "QU", "F", "U", "V", "O", "R", "C", "K", "Q", "G", "W", "H", "N", "I", "J", "P", "X", "S", "Z", "T", "B", "E", "M", "L", "D", "A", "Y"]

    string = string.upper()
    for char in chars:
        string = re.sub(char, runes[chars.index(char)], string)

    return string

def get_liber_primus_words():
    word_list = []

    f = open('liber_primus_words.rne', 'r')
    
    for line in f.readlines():
        word_list.append(line.strip())

    f.close()
    return word_list

def get_liber_primus():
    sections = []
    pages = []
    
    f = open('transcriptions.rne')
    contents = f.read()
    f.close()

    n = 0
    for page in contents.split('\n\n'):
        if n == 50:
            pages.append("")

        pages.append(re.sub("\n", "", page))
        n += 1

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


def runes_to_english(runeword):
    dictable = {entry[0]:entry[1] for entry in table}
    res = ""
    for rune in runeword:
        res += dictable[rune]

    return res

def get_rune_pos(rune):
    for i in range(len(table)):
        if rune in table[i]:
            return i

    return None

def shifted_text(text, ansatz, direction):
    shifted = ""

    j = 0
    i = 0
    while i < len(ansatz) and j < len(text):
        rune1 = text[j]
        rune2 = ansatz[i]
        
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

ansatz = "PARABLE"
SECTION_NUM = 0

rune_ansatz = english_to_runes(ansatz)
liber_primus = get_liber_primus()

section = liber_primus[SECTION_NUM]

f = open('key_phrases/' + ansatz + '_' + str(SECTION_NUM) + '.txt', 'a')
f.write('------- BEGIN KEY \"' + ansatz + '\" -------\n')
f.write('SECTION ' + str(SECTION_NUM) + '\n\n')

for i in range(len(section) - len(rune_ansatz)):
    f.write("Pos: " + "%-6s"%str(i) + " Forward :\t" + shifted_text(section[i:], rune_ansatz, 0) + '\n')
    f.write("Pos: " + "%-6s"%str(i) + " Backward:\t" + shifted_text(section[i:], rune_ansatz, 1) + '\n')

f.write('------- END KEY \"' + ansatz + '\" -------\n')
f.close()
