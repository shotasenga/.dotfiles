# an shorthand for `find ... | sed ..` to replace matches in files
#
# findreplace <globa pattern for file name> <matcher> <replacement>
# ex) to replace KICK with ASS
#   findreplace *.txt KICK ASS
function findreplace
    find . -type f -name $argv[1] -exec sed -i '' -e "s|$argv[2]|$argv[3]|" \{\} \;
end
