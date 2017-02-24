## Solution to Task 5 Question 4

```bash
for file in *log; do
	var=$(grep "run-time" $file | grep -o " [0-9]\." | grep -o "[0-9]")
	if [[ $var -lt 9 ]]; then
		echo "$file : $var"
	fi
done
```
