function explain
	if test (count $argv) -eq 0
while read -p "Command: " cmd
curl -Gs "https://www.mankier.com/api/explain/?cols="(tput cols) --data-urlencode "q=$cmd"
end
echo "Bye!"
else if test (count $argv) -eq 1
curl -Gs "https://www.mankier.com/api/explain/?cols="(tput cols) --data-urlencode "q=$argv[1]"
else
echo "Usage"
echo "explain                  interactive mode."
echo "explain 'cmd -o | ...'   one quoted command to explain it."
end
end
