from pathlib import Path

ROOT = Path(__file__).resolve().parent
CONSTRAINTS = ROOT.parent.parent / "data" / "constraints"
#CONTENT = ROOT / "content"

#(CONTENT / "boards").mkdir(exist_ok=True)

BOARDS = {}

for item in (CONSTRAINTS / "board").glob("**/*.yml"):

    if item.name != "info.yml":
        name = item.stem
        prefix = ".todo/"
        suffix = ".yml"
        print("·", name)
    else:
        name = item.parent.name
        prefix = ""
        suffix = ""
        print("-", name)

#    with (CONTENT / "boards" / (name + ".md")).open("w") as wfptr:
#        wfptr.write("---\n")
#        wfptr.write(item.read_text())
#        wfptr.write(
#            "ref: https://github.com/hdl/constraints/tree/main/board/%s%s%s\n"
#            % (prefix, name, suffix)
#        )
#        wfptr.write("---\n")

for item in (CONSTRAINTS / "board").glob("**/*.md"):

    if item.name != "README.md":
        name = item.stem
        prefix = ".todo/"
        suffix = ".md"
        print("·", name)
    else:
        name = item.parent.name
        prefix = ""
        suffix = ""
        print("-", name)

#    with item.open("r") as rfptr:
#        with (CONTENT / "boards" / (name + ".md")).open("w") as wfptr:
#            for line in [
#                "---",
#                "ref: https://github.com/hdl/constraints/tree/main/board/%s%s%s"
#                % (prefix, name, suffix),
#            ] + rfptr.read().splitlines()[1:]:
#                wfptr.writelines("{}\n".format(line))